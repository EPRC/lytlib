;########################################################
;	structure define
;########################################################
defstruct(size_rect
		len
		wid
)

;########################################################
;	Other method
;########################################################

procedure(_init_rect_(inst)
	let(()
		inst->size=make_size_rect(
			?len 0
			?wid 0
		)
	)
)

procedure(_delete_rect_(obj)
	let(
		()
		print("delete")
	)
)



;########################################################
;	Size Modify method
;########################################################
procedure(_getSize_rect_(obj)
	prog(
		(size)
		if(defstructp(obj->size 'size_rect) then
			size=copy_size_rect(obj->size)
			return(size)
		else
			println("get Size failed!")
			println("error: the object is not a valid ccObj")	
			return(nil)	
		);if
		
	)
)

procedure(_setSize_rect_(obj @optional (arg1 nil) (arg2 nil) (arg3 nil) (arg4 nil))
	let(
		()
		cond(
			(arg2
				{
					obj->size->len=arg1
					obj->size->wid=arg2
				}
			)
			
			(defstructp(arg1 'ccObj)
				{
					obj->size->len=arg1->size->len
					obj->size->wid=arg1->size->wid
				}
			)
			
			(arg1
				{
					obj->size->len=arg1->len
					obj->size->wid=arg1->wid
				}
			)
			
			(t
				return -1
			)
		)
	)
)

procedure(_extend_rect_(obj len @optional (wid nil) (arg1 nil) (arg2 nil))
	let(
		(ref)
		ref=obj->ref
		changeRef(obj CENT)
		if(wid 
			then
				obj->size->len=obj->size->len+len*2
				obj->size->wid=obj->size->wid+wid*2
			else
				obj->size->len=obj->size->len+len*2
				obj->size->wid=obj->size->wid+len*2
		);if
		obj->pattern->refresh(obj)
		changeRef(obj ref)
	)
)

procedure(_shrink_rect_(obj len @optional (wid nil) (arg1 nil) (arg2 nil))
	let(
		(ref)
		ref=obj->ref
		changeRef(obj CENT)
		if(wid 
			then
				obj->size->len=obj->size->len-len*2
				obj->size->wid=obj->size->wid-wid*2
			else
				obj->size->len=obj->size->len-len*2
				obj->size->wid=obj->size->wid-len*2
		);if
		obj->pattern->refresh(obj)
		changeRef(obj ref)
	)
)

;########################################################
;	Graphic method
;########################################################


procedure(_draw_rect_(obj)
	prog(
		(i vn_temp id_temp)
		if(obj->mat then
		obj->cc_id=dbCreatePolygon(obj->lyt->view_ID list(obj->mat "drawing") list(	obj->lbpos->x			:	obj->lbpos->y 
												obj->lbpos->x			:	obj->lbpos->y+obj->size->wid
												obj->lbpos->x+obj->size->len	:	obj->lbpos->y+obj->size->wid
												obj->lbpos->x+obj->size->len	:	obj->lbpos->y
												obj->lbpos->x			:	obj->lbpos->y))
		);if
		
		if(obj->ct_list
			then
				foreach(i obj->ct_list
					vn_temp=strcat("c_" i->mat "_" pcExprToString(i->size) "*" pcExprToString(i->size))
					i->id=dbOpenCellViewByType(obj->lyt->view_ID->libName vn_temp "layout" "maskLayout" "r")
					if(i->id
						then
							;	
						else
							i->id=dbOpenCellViewByType(obj->lyt->view_ID->libName vn_temp "layout" "maskLayout" "a")
							createRect(i->id i->mat 0 0 i->size i->size)
							dbSave(i->id)
					);if
					id_temp=dbCreateSimpleMosaic(obj->lyt->view_ID i->id nil list(i->iX+i->offset1 i->iY+i->offset2) "R0" i->nY i->nX i->size+i->space i->size+i->space)
					obj->ct_id=append1(obj->ct_id id_temp)
				);foreach
		);if
		return obj->cc_id
	)
)

procedure(_create_contact_(obj conf @optional arg1)
	let(
		(iL iW w_c s_c)
		cfg=copy_ctCfg(conf)
		
		cfg->iX=obj->lbpos->x
		cfg->iY=obj->lbpos->y
		
		if(arg1
			then
				iL=obj->size->len-arg1*2
				iW=obj->size->wid-arg1*2
			else
				iL=obj->size->len
				iW=obj->size->wid
		)
		
		w_c=cfg->size
		s_c=cfg->space
		
		cfg->nX=round((iL-s_c)/(w_c+s_c))
		cfg->nY=round((iW-s_c)/(w_c+s_c))

		if(cfg->nX==0
			then 	cfg->nX=1
				cfg->offset1=(iL-w_c)/2
			else
				cfg->offset1=(iL-(w_c+s_c)*cfg->nX+s_c)/2
		);if

		if(cfg->n_Y==0
			then 	cfg->n_Y=1
				cfg->offset2=(iW-w_c)/2
			else
				cfg->offset2=(iW-(w_c+s_c)*cfg->nY+s_c)/2
		);if

		
		obj->ct_list=append1(obj->ct_list cfg)
	)
)


rect=make_patternObj(
			?name		"rectangle"
			?type		"pattern"
			?init		'_init_rect_
			?refresh 	'_refresh_
			?getPos		'_getPos_
			?setPos		'_setPos_
			?move		'_move_
			?changeRef	'_changeRef_
			?getPoint	'_getPoint_
			?getSize	'_getSize_rect_
			?setSize	'_setSize_rect_
			?extend		'_extend_rect_
			?shrink		'_shrink_rect_
			?delete		'_delete_rect_
			?clear		'_clear_
			?draw		'_draw_rect_
			?makeContact	'_create_contact_
			
			
			?writeParser	'_writePs_
			?endParser	'_endPs_
)
