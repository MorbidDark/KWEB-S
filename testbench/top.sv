module top();
    imem 
    #(
        .width      (width      ),
        .depth      (depth      ),
        .addr_width (addr_width )
    )
    u_imem(
        .a  (a  ),
        .rd (rd )
    );
    
endmodule