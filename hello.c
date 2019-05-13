	#include "veriuser.h"
	static hello()
	{	io_printf("********************************** \n");
		io_printf("Hello from ERA aero, BRNO, CZE !!!! \n");
		io_printf("********************************** \n");
	}
	s_tfcell veriusertfs[] = {
		{usertask, 0, 0, 0, hello, 0, "$hello"},
		{0}  /* last entry must be 0 */
	}; 
