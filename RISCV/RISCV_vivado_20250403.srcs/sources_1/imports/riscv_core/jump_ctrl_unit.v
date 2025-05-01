/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: jump_ctrl_unit.v
 * Description: 冒险检测单元
 * 
 */
module jump_ctrl_unit(

    input      jump         ,
    output reg if_id_clear  ,
    output reg id_ex_clear  ,
    output reg ctrl_clear   ,
    output reg pc_sel     
);

    always@(*)begin
        if (jump == 1'b1)begin
            if_id_clear = 1'b1 ;
            id_ex_clear = 1'b1 ; 
            ctrl_clear  = 1'b1 ;
            pc_sel      = 1'b1 ;
        end 
	else begin 
	        if_id_clear = 1'b0 ;
            id_ex_clear = 1'b0 ; 
            ctrl_clear  = 1'b0 ;
            pc_sel      = 1'b0 ;
        end
    end
endmodule
