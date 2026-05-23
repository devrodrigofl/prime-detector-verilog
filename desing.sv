module prime_detector(
    input wire [3:0] N,
    output wire P
);

    wire not_n3, not_n2, not_n1;
    wire or1_out, or2_out, or3_out, or4_out, or5_out;
    wire and1_out, and2_out;

    not inv_n3 (not_n3, N[3]);
    not inv_n2 (not_n2, N[2]);
    not inv_n1 (not_n1, N[1]);

    or soma1 (or1_out, N[2], N[1]);
    or soma2 (or2_out, not_n2, N[0]);
    or soma3 (or3_out, not_n3, N[0]);
    or soma4 (or4_out, not_n3, not_n2);
  	or soma5 (or5_out, or4_out, not_n1);

    and mult1 (and1_out, or1_out, or2_out);
  	and mult2 (and2_out, or3_out, or5_out);
    and mult3 (P, and1_out, and2_out);

endmodule
