TOP=1<<0
BOT=1<<1
LT=1<<2
RT=1<<3
CENT=1<<4
DIR_X=LT|RT
DIR_Y=TOP|RT
ALL=TOP|BOT|LT|RT

EXT=1<<8
INT=1<<9

defstruct(posObj
			x	;	
			y	;
)

defstruct(ccObj
			name	;	name of the instance
			type	;	
			pos	;	center Position of the cell : posObj
			
			ref	;	reference point of the cell : element in {
				;					"lt"(left-top) 
				;					"lb"(left-bottom)
				;					"rt"(right-top)
				; 					"rb"(right-bottom) 
				;					"c"(center)
				;					}

			pattern	;	pattern of the cell : element in {
				;					"rect"(rectangle)
				;					"circle"(circle)
				;					"oct"(octangle)
			
			size	;	size of the cell. might be in different data structure for each type:
				;		for rect : size
				;		for circle : diameter
				;		for octangle : list{width length len1}

			mat	;	layer type of the sharp

			lyt	;	the target lytObj id

			ltpos
			lbpos
			rtpos
			rbpos
			cpos	
			ctpos
			cbpos
			lcpos
			rcpos	;	similar to pos

			cc_id	;	binded sharp ID in layout
			
			ct_list ;	contact cfg list
			ct_id	;	contact ID list						

			anchor	;	upper level ccObj	: id

			son	;	lower level ccObjs	: list(id_1 id_2)
			
			visible;	if visible	: t or nil
		)
			

defstruct(lytObj
			lib_Name ;	the library Name of layout view
			
			cell_Name;	the cell Name of layout view
		
			view_ID	;	cellview ID of the layout view	

			son	;	list of son object
			
			init	;	initialize method 

			obj_to_draw;
			
		)
