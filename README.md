# tangram
vga输出七巧板，可以旋转和移动，

vga_driver:生成vga接口要的时序图，驱动vga的十五根线

vga_display:调用shape里的shape

vga_shape：各个形状（两种三角形、菱形、平行四边形）的描述，包括旋转后的。描述方法是以（hc-px,vc-py）为零点，size为边长的线围起来的区域。

vga_top:调用其它模块


新手，不懂怎么优化代码，减少面积、时序啥的，酌情参考。

好像还有一点bug。
