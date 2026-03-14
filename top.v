module mult(
    input [3:0] CEO,
    input [3:0] You,
    input [3:0] Fred,
    input [3:0] Jill,
    input [1:0] Sel,
    input Enable,
    output [3:0] Out
);

    assign Out = Enable ? (Sel == 2'b00 ? CEO  :
                         Sel == 2'b01 ? You  :
                         Sel == 2'b10 ? Fred :
                         Sel == 2'b11 ? Jill : 0) 
                      : 0;

endmodule

module demult(
    input [3:0] In,
    input [1:0] Sel,
    input Enable,
    output [3:0] local_lib,
    output [3:0] fire_dept,
    output [3:0] school,
    output [3:0] rib_shack
);

    assign local_lib = (Enable && Sel == 2'b00 ? In : 0);
    assign fire_dept = (Enable && Sel == 2'b01 ? In : 0);
    assign school = (Enable && Sel == 2'b10 ? In : 0);
    assign rib_shack = (Enable && Sel == 2'b11 ? In : 0);
    

endmodule

module top(
    input [15:0] sw,
    input btnL,
    input btnU,
    input btnD,
    input btnR,
    input btnC,
    output [15:0] led
);
    wire [1:0] mult_sel;
    wire [1:0] demult_sel;
    wire [3:0] outWire;
    assign mult_sel = {btnU, btnL};
    assign demult_sel = {btnR, btnD};
    
    mult mult_inst(
    .CEO(sw[3:0]),
    .You(sw[7:4]),
    .Fred(sw[11:8]),
    .Jill(sw[15:12]),
    .Sel(mult_sel),
    .Enable(btnC),
    .Out(outWire)
    );
    
    demult demult_inst(
     .In(outWire),
     .Sel(demult_sel),
     .Enable(btnC),
     .local_lib(led[3:0]),
     .fire_dept(led[7:4]),
     .school(led[11:8]),
     .rib_shack(led[15:12])
    );

endmodule