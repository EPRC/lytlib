;########################################################
;	structure define
;########################################################
defstruct(size_inst
		len
		wid
		offset_X
		offset_Y
		inst_name
		inst_id
)

;########################################################
;	Other method
;########################################################
procedure(_refresh_inst_(inst)
	let((bBox)
		_refresh_(inst)
		cond(
			((inst->size->inst_name)&&(inst->size->inst_id==nil)
				{
					inst->size->inst_id=dbOpenCellViewByType(inst->lyt->lib_Name inst->size->inst_name "layout" "maskLayout" "r")
					bBox=inst->size->inst_id->bBox
					inst->size->len=nth(0 nth(1 bBox))-nth(0 nth(0 bBox))
					inst->size->wid=nth(1 nth(1 bBox))-nth(1 nth(0 bBox))
					inst->size->offset_X=xCoord(lowerLeft(bBox))
					inst->size->offset_Y=yCoord(lowerLeft(bBox))
					_refresh_(inst)
				}
			)
			
			((inst->size->inst_name==nil)&&(inst->size->inst_id)
				{
					inst->size->inst_name=inst->size->inst_id->cellName
					bBox=inst->size->inst_id->bBox
					inst->size->len=nth(0 nth(1 bBox))-nth(0 nth(0 bBox))
					inst->size->wid=nth(1 nth(1 bBox))-nth(1 nth(0 bBox))
					inst->size->offset_X=xCoord(lowerLeft(bBox))
					inst->size->offset_Y=yCoord(lowerLeft(bBox))
					_refresh_(inst)
				}
			)
			
			(t
				print("Set inst name first")
			)
		)
	)
)

;########################################################
;	Other method
;########################################################

procedure(_init_inst_(inst)
	let(()
		inst->size=make_size_inst(
			?len 	0
			?wid 	0
			?offset_X 0
			?offset_Y 0
			?inst_name 	nil
			?inst_id	nil
		)
	)
)

procedure(_delete_inst_(obj)
	let(
		()
		print("delete")
	)
)

;########################################################
;	Size Modify method
;########################################################

procedure(_getSize_inst_(obj)
	prog(
		(size)
		if(defstructp(obj->size 'size_inst) then
			size=copy_size_inst(obj->size)
			return(size)
		else
			println("get Size failed!")
			println("error: the object is not a valid ccObj")	
			return(nil)	
		);if
		
	)
)

procedure(_setSize_inst_(obj @optional (arg1 nil) (arg2 nil) (arg3 nil) (arg4 nil))
	let(
		()
		print("Warinning: instance pattern dose not support setSize method")
	)
)

procedure(_extend_inst_(obj len wid @optional (arg1 nil) (arg2 nil))
	let(
		()
		print("Warining: instance pattern dose not support extend method")
	)
)

procedure(_shrink_inst_(obj len wid @optional (arg1 nil) (arg2 nil))
	let(
		()
		print("Warining: instance pattern dose not support extend method")
	)
)

procedure(_draw_inst_(obj)
	prog(
		()
		if(obj->size->inst_id then
			obj->cc_id=dbCreateInst(obj->lyt->view_ID obj->size->inst_id nil list(obj->pos->lbpos->x obj->pos->lbpos->y) "R0" 1)
			return(obj->cc_id)
		else
			println("can't get instance according to the given name")
		)
	)
)

procedure(setInstName(obj name)
	let(()
		obj->size->inst_name=name
		obj->size->inst_id=nil
		obj->pattern->refresh(obj)
	)
)

procedure(setInst(obj inst)
	let(()
		if(defstructp(inst 'lytObj) then
			obj->size->inst_id=inst->view_ID
			obj->size->inst_name=nil
			obj->pattern->refresh(obj)
		else
			error("the seacond arguement should be a lyt object")
		)
	)
)

instance=make_patternObj(
			?name		"instance"
			?type		"pattern"
			?init		'_init_inst_
			?refresh 	'_refresh_inst_
			?getPos		'_getPos_
			?setPos		'_setPos_
			?move		'_move_
			?changeRef	'_changeRef_
			?getPoint	'_getPoint_
			?getSize	'_getSize_inst_
			?setSize	'_setSize_inst_
			?extend		'_extend_inst_
			?shrink		'_shrink_inst_
			?delete		'_delete_inst_
			?clear		'_clear_
			?draw		'_draw_inst_
			?makeContact	'_create_contact_
			
			?writeParser	'_writePs_
			?endParser	'_endPs_
)


