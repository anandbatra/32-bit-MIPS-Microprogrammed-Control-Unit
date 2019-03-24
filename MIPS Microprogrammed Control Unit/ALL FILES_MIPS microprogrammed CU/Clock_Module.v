module Clock_Module(out);
output out;
reg    out;
                        
initial begin
        out = 1'b1;
end

always
begin
        out = #10 ~out;
end
endmodule

