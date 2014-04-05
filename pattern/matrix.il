;########################################################
;	structure define
;########################################################
defstruct(size_matrix
		len
		wid
		n_x
		n_y
		spac_x
		spac_y
		cell_obj
		offset_x
		offset_y
		
)

;########################################################
;	Other method
;########################################################
procedure(_refresh_matrix_(inst)
	let(()
		_refresh_(inst)
		
		if(inst->size->cell_obj&&inst->size->cell_obj->size&&(inst->size->spac_x+inst->size->cell_obj->size->len)!=0&&(inst->size->spac_y+inst->size->cell_obj->size->wid)!=0 then
			;inst->size->n_x=round((inst->size->len+inst->size->cell_obj->size->len)/(inst->size->spac_x+inst->size->cell_obj->size->len))
			;inst->size->n_y=round((inst->size->wid+inst->size->cell_obj->size->wid)/(inst->size->spac_y+inst->size->cell_obj->size->wid))
			inst->size->n_x=round((inst->size->len+inst->size->spac_x)/(inst->size->spac_x+inst->size->cell_obj->size->len))
			inst->size->n_y=round((inst->size->wid+inst->size->spac_y)/(inst->size->spac_y+inst->size->cell_obj->size->wid))
			case(inst->ref
				(5 
					{
						inst->size->offset_x=-inst->size->cell_obj->size->offset_X
						inst->size->offset_y=inst->size->wid-inst->size->n_y*inst->size->cell_obj->size->wid-(inst->size->n_y-1)*inst->size->spac_y-inst->size->cell_obj->size->offset_Y
					}
				)
				(6
					{
						inst->size->offset_x=-inst->size->cell_obj->size->offset_X
						inst->size->offset_y=-inst->size->cell_obj->size->offset_Y
					}
				)
				(9 
					{
						inst->size->offset_x=inst->size->len-inst->size->n_x*inst->size->cell_obj->size->len-(inst->size->n_x-1)*inst->size->spac_x-inst->size->cell_obj->size->offset_X
						inst->size->offset_y=inst->size->wid-inst->size->n_y*inst->size->cell_obj->size->wid-(inst->size->n_y-1)*inst->size->spac_y-inst->size->cell_obj->size->offset_Y
					}
				)
				(10 
					{
						inst->size->offset_x=inst->size->len-inst->size->n_x*inst->size->cell_obj->size->len-(inst->size->n_x-1)*inst->size->spac_x-inst->size->cell_obj->size->offset_X
						inst->size->offset_y=-inst->size->cell_obj->size->offset_Y
					}
				)
				(17 
					{
						inst->size->offset_x=(inst->size->len-inst->size->n_x*inst->size->cell_obj->size->len-(inst->size->n_x-1)*inst->size->spac_x)/2.0-inst->size->cell_obj->size->offset_X
						inst->size->offset_y=inst->size->wid-inst->size->n_y*inst->size->cell_obj->size->wid-(inst->size->n_y-1)*inst->size->spac_y-inst->size->cell_obj->size->offset_Y
					}
				)
				(18 
					{
						inst->size->offset_x=(inst->size->len-inst->size->n_x*inst->size->cell_obj->size->len-(inst->size->n_x-1)*inst->size->spac_x)/2.0-inst->size->cell_obj->size->offset_X
						inst->size->offset_y=-inst->size->cell_obj->size->offset_Y
					}
				)
				(24 
					{
						inst->size->offset_x=inst->size->len-inst->size->n_x*inst->size->cell_obj->size->len-(inst->size->n_x-1)*inst->size->spac_x-inst->size->cell_obj->size->offset_X
						inst->size->offset_y=(inst->size->wid-inst->size->n_y*inst->size->cell_obj->size->wid-(inst->size->n_y-1)*inst->size->spac_y)/2.0-inst->size->cell_obj->size->offset_Y
					}
				)
				(20 
					{
						inst->size->offset_x=-inst->size->cell_obj->size->offset_X
						inst->size->offset_y=(inst->size->wid-inst->size->n_y*inst->size->cell_obj->size->wid-(inst->size->n_y-1)*inst->size->spac_y)/2.0-inst->size->cell_obj->size->offset_Y
					}
				)
				(16  
					{
						inst->size->offset_x=(inst->size->len-inst->size->n_x*inst->size->cell_obj->size->len-(inst->size->n_x-1)*inst->size->spac_x)/2.0-inst->size->cell_obj->size->offset_X
						inst->size->offset_y=(inst->size->wid-inst->size->n_y*inst->size->cell_obj->size->wid-(inst->size->n_y-1)*inst->size->spac_y)/2.0-inst->size->cell_obj->size->offset_Y
					}
				)
				(t flag=nil)
			)
		)	
	)
)	

procedure(_init_matrix_(inst)
	let(()
		inst->size=make_size_matrix(
			?len 	0
			?wid 	0
			?n_x 	0
			?n_y 	0
			?spac_x 0
			?spac_y 0
			?cell_obj 	nil 
		)
	)
)

procedure(_delete_matrix_(inst)
	let(()
		print("delete")
	)
)

;########################################################
;	Size Modify method
;########################################################
procedure(_getSize_matrix_(obj)
	prog(
		(size)
		if(defstructp(obj->size 'size_matrix) then
			size=copy_size_matrix(obj->size)
			return(size)
		else
			println("get Size failed!")
			println("error: the object is not a valid ccObj")	
			return(nil)	
		);if
		
	)
)

procedure(_setSize_matrix_(obj @optional (arg1 nil) (arg2 nil) (arg3 nil) (arg4 nil))
	let(
		()
		cond(
			(arg4
				{
					obj->size->len=arg1
					obj->size->wid=arg2
					obj->size->spac_x=arg3
					obj->size->spac_y=arg4
				}
			)
			(arg2
				{
					obj->size->len=arg1
					obj->size->wid=arg2
				}
			)
			
			(defstructp(arg1 'size_matrix)
				{
					obj->size->len = arg1->len
					obj->size->wid = arg1->wid
					obj->size->n_x = arg1->n_x
					obj->size->n_y = arg1->n_y
					obj->size->spac_x = arg1->spac_x
					obj->size->spac_y = arg1->spac_y
					obj->size->cell_obj = arg1->cell_obj
					obj->size->offset_x=arg1->offset_x
					obj->size->offset_y=arg1->offset_y
				}
			)
			
			
			(defstructp(arg1 'ccObj)
				{
					obj->size->len = arg1->size->len
					obj->size->wid = arg1->size->wid
				}
			)
			
			
			(arg1
				{
					obj->size->len = arg1->len
					obj->size->wid = arg1->wid
				}
			)
			
			(t
				return -1
			)
		)
		refresh_ccOBJ(obj)
	)
)

procedure(_extend_matrix_(obj len wid @optional (arg1 nil) (arg2 nil))
	let(
		(ref)
		ref=obj->ref
		changeRef(obj CENT)
		obj->size->len=obj->size->len+len*2
		obj->size->wid=obj->size->wid+wid*2
		obj->pattern->refresh(obj)
		changeRef(obj ref)
	)
)

procedure(_shrink_matrix_(obj len wid @optional (arg1 nil) (arg2 nil))
	let(
		(ref)
		ref=obj->ref
		changeRef(obj CENT)
		obj->size->len=obj->size->len-len*2
		obj->size->wid=obj->size->wid-wid*2
		obj->pattern->refresh(obj)
		changeRef(obj ref)
	)
)

procedure(_draw_matrix_(obj)
	let(
		(x_pos y_pos x_it y_it i j temp_ccobj temp_id)
		x_pos=obj->lbpos->x+obj->size->offset_x
		y_pos=obj->lbpos->y+obj->size->offset_y
		x_it=x_pos
		y_it=y_pos
		
		if(defstructp(obj->size->cell_obj 'ccObj) then
			if(defstructp(obj->size->cell_obj->size 'size_inst) then
				temp_ccobj=createSOBJ(instance)
				changeRef(temp_ccobj LT|BOT)
				setLyt(temp_ccobj obj)
				setPos(temp_ccobj obj)
				setSize(temp_ccobj getSize(obj->size->cell_obj))
				setAnchor(temp_ccobj obj)
				temp_ccobj->cc_id=dbCreateSimpleMosaic(obj->size->cell_obj->lyt->view_ID obj->size->cell_obj->size->inst_id nil list(x_pos y_pos) "R0" obj->size->n_y obj->size->n_x obj->size->spac_x+obj->size->cell_obj->size->len obj->size->spac_y+obj->size->cell_obj->size->wid)
			else
				
				for(i 1 obj->size->n_x
					for(j 1 obj->size->n_y
						temp_ccobj=createSOBJ(obj->size->cell_obj->pattern)
						changeRef(temp_ccobj LT|BOT)
						setPos(temp_ccobj x_pos	y_pos)
						setMat(temp_ccobj obj->size->cell_obj->mat)
						setSize(temp_ccobj obj->size->cell_obj->size)
						setAnchor(temp_ccobj obj)
						draw(temp_ccobj)

						y_pos=y_pos+obj->size->spac_y+obj->size->cell_obj->size->wid
					)
					x_pos=x_pos+obj->size->spac_x+obj->size->cell_obj->size->len
					y_pos=y_it
				)
			
			)		
		)	
	)
)

procedure(setMatrixCell(obj prototype)
	let(()
		cond(
			(defstructp(prototype 'lytObj)
				obj->size->cell_obj=createSOBJ(instance obj->lyt)
				setInst(obj->size->cell_obj prototype)
			)
			
			(defstructp(prototype 'ccObj)
				obj->size->cell_obj=prototype
				changeRef(obj->size->cell_obj LT|BOT)
				setPos(obj->size->cell_obj 0 0)
			)
			
			(t
				print("the prototype could only be a lytObj or a ccObj")
			)
		)	
		
		refresh_ccOBJ(obj)		
	)
)

matrix=make_patternObj(
			?name		"matrix"
			?type		"pattern"
			?init		'_init_matrix_
			?refresh 	'_refresh_matrix_
			?getPos		'_getPos_
			?setPos		'_setPos_
			?move		'_move_
			?changeRef	'_changeRef_
			?getPoint	'_getPoint_
			?getSize	'_getSize_matrix_
			?setSize	'_setSize_matrix_
			?extend		'_extend_matrix_
			?shrink		'_shrink_matrix_
			?delete		'_delete_matrix_
			?clear		'_clear_
			?draw		'_draw_matrix_
			?makeContact	'_create_contact_
			
			?writeParser	'_writePs_
			?endParser	'_endPs_
)
