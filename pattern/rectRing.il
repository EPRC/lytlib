;########################################################
;	structure define
;########################################################
defstruct(size_rring
		len
		wid
		wid1
		wid2
)

;########################################################
;	Other method
;########################################################

procedure(_init_rring_(inst)
	let(()
		inst->size=make_size_rring(
			?len 0
			?wid 0
			?wid1 0
			?wid2 0
		)
	)
)

procedure(_refresh_rring_(inst)
	let((i)
		case(inst->ref
			(5 {
				setPosOrigin(inst->ltpos inst->pos->x inst->pos->y)
				setPosOrigin(inst->lbpos inst->pos->x  inst->pos->y-inst->size->wid)
				setPosOrigin(inst->rtpos inst->pos->x+inst->size->len  inst->pos->y)
				setPosOrigin(inst->rbpos inst->pos->x+inst->size->len  inst->pos->y-inst->size->wid)
				setPosOrigin(inst->cpos  inst->pos->x+inst->size->len/2.0  inst->pos->y-inst->size->wid/2.0)
				})
			(6 {
				setPosOrigin(inst->ltpos inst->pos->x  inst->pos->y+inst->size->wid)
				setPosOrigin(inst->lbpos inst->pos->x  inst->pos->y)
				setPosOrigin(inst->rtpos inst->pos->x+inst->size->len  inst->pos->y+inst->size->wid)
				setPosOrigin(inst->rbpos inst->pos->x+inst->size->len  inst->pos->y)
				setPosOrigin(inst->cpos  inst->pos->x+inst->size->len/2.0  inst->pos->y+inst->size->wid/2.0)
				})
			(9 {
				setPosOrigin(inst->ltpos inst->pos->x-inst->size->len  inst->pos->y)
				setPosOrigin(inst->lbpos inst->pos->x-inst->size->len  inst->pos->y-inst->size->wid)
				setPosOrigin(inst->rtpos inst->pos->x  inst->pos->y)
				setPosOrigin(inst->rbpos inst->pos->x  inst->pos->y-inst->size->wid)
				setPosOrigin(inst->cpos  inst->pos->x-inst->size->len/2.0  inst->pos->y-inst->size->wid/2.0)
				})
			(10 {
				setPosOrigin(inst->ltpos inst->pos->x-inst->size->len  inst->pos->y+inst->size->wid)
				setPosOrigin(inst->lbpos inst->pos->x-inst->size->len  inst->pos->y)
				setPosOrigin(inst->rtpos inst->pos->x  inst->pos->y+inst->size->wid)
				setPosOrigin(inst->rbpos inst->pos->x  inst->pos->y)
				setPosOrigin(inst->cpos  inst->pos->x-inst->size->len/2.0  inst->pos->y+inst->size->wid/2.0)
				})
			(16 {
				setPosOrigin(inst->ltpos inst->pos->x-inst->size->len/2.0  inst->pos->y+inst->size->wid/2.0)
				setPosOrigin(inst->lbpos inst->pos->x-inst->size->len/2.0  inst->pos->y-inst->size->wid/2.0)
				setPosOrigin(inst->rtpos inst->pos->x+inst->size->len/2.0  inst->pos->y+inst->size->wid/2.0)
				setPosOrigin(inst->rbpos inst->pos->x+inst->size->len/2.0  inst->pos->y-inst->size->wid/2.0)
				setPosOrigin(inst->cpos  inst->pos->x  inst->pos->y)
				})
			(17 {
				setPosOrigin(inst->ltpos inst->pos->x-inst->size->len/2.0  inst->pos->y)
				setPosOrigin(inst->lbpos inst->pos->x-inst->size->len/2.0  inst->pos->y-inst->size->wid)
				setPosOrigin(inst->rtpos inst->pos->x+inst->size->len/2.0  inst->pos->y)
				setPosOrigin(inst->rbpos inst->pos->x+inst->size->len/2.0  inst->pos->y-inst->size->wid)
				setPosOrigin(inst->cpos  inst->pos->x  inst->pos->y-inst->size->wid/2.0)
				})
			(18 {
				setPosOrigin(inst->ltpos inst->pos->x-inst->size->len/2.0  inst->pos->y+inst->size->wid)
				setPosOrigin(inst->lbpos inst->pos->x-inst->size->len/2.0  inst->pos->y)
				setPosOrigin(inst->rtpos inst->pos->x+inst->size->len/2.0  inst->pos->y+inst->size->wid)
				setPosOrigin(inst->rbpos inst->pos->x+inst->size->len/2.0  inst->pos->y)
				setPosOrigin(inst->cpos  inst->pos->x  inst->pos->y+inst->size->wid/2.0)
				})
			(20 {
				setPosOrigin(inst->ltpos inst->pos->x inst->pos->y+inst->size->wid/2.0)
				setPosOrigin(inst->lbpos inst->pos->x inst->pos->y-inst->size->wid/2.0)
				setPosOrigin(inst->rtpos inst->pos->x+inst->size->len  inst->pos->y+inst->size->wid/2.0)
				setPosOrigin(inst->rbpos inst->pos->x+inst->size->len  inst->pos->y-inst->size->wid/2.0)
				setPosOrigin(inst->cpos  inst->pos->x+inst->size->len/2.0  inst->pos->y)
				})
			(24 {
				setPosOrigin(inst->ltpos inst->pos->x-inst->size->len  inst->pos->y+inst->size->wid/2.0)
				setPosOrigin(inst->lbpos inst->pos->x-inst->size->len  inst->pos->y-inst->size->wid/2.0)
				setPosOrigin(inst->rtpos inst->pos->x  inst->pos->y+inst->size->wid/2.0)
				setPosOrigin(inst->rbpos inst->pos->x  inst->pos->y-inst->size->wid/2.0)
				setPosOrigin(inst->cpos  inst->pos->x-inst->size->len/2.0  inst->pos->y)
				})
			(t nil)
		)

		setPosOrigin(inst->ctpos inst->cpos->x inst->ltpos->y)
		setPosOrigin(inst->cbpos inst->cpos->x inst->lbpos->y)
		setPosOrigin(inst->lcpos inst->ltpos->x inst->cpos->y)
		setPosOrigin(inst->rcpos inst->rtpos->x inst->cpos->y)
	)
)

procedure(_delete_rring_(obj)
	let(
		()
		print("delete")
	)
)

procedure(_move_rring_(obj x y)
	let(
		()
		obj->pos->x=obj->pos->x+x
		obj->pos->y=obj->pos->y+y
		
		if(obj->ct_list then
			foreach(i obj->ct_list
				i->iX=i->iX+x
				i->iY=i->iY+y
			);foreach		
		)
	)
)


;########################################################
;	Size Modify method
;########################################################
procedure(_getSize_rring_(obj)
	prog(
		(size)
		if(defstructp(obj->size 'size_rring) then
			size=copy_size_rring(obj->size)
			return(size)
		else
			println("get Size failed!")
			println("error: the object is not a valid ccObj")	
			return(nil)	
		);if
		
	)
)

procedure(_setSize_rring_(obj @optional (arg1 nil) (arg2 nil) (arg3 nil) (arg4 nil))
	let(
		()
		cond(
			(defstructp(arg1 'ccObj)&&arg2&&arg3
				{
					obj->size->len=arg1->size->len+arg2*2
					obj->size->wid=arg1->size->wid+arg3*2
					obj->size->wid1=arg3
					obj->size->wid2=arg4
				}
			)
			
			(defstructp(arg1 'ccObj)&&arg2
				{
					obj->size->len=arg1->size->len+arg2*2
					obj->size->wid=arg1->size->wid+arg2*2
					obj->size->wid1=arg2
					obj->size->wid2=arg2
				}
			)
			
			(defstructp(arg1 'ccObj)
				{
					if(arg1->size->wid1&&arg1->size->wid2 then
						obj->size->wid1=arg1->size->wid1
						obj->size->wid2=arg1->size->wid2
					)
					
					obj->size->len=arg1->size->len+obj->size->wid1*2
					obj->size->wid=arg1->size->wid+obj->size->wid2*2	
				}
			)
			
			(defstructp(arg1 'size_rring)
				{
					obj->size->wid1=arg1->wid1
					obj->size->wid2=arg1->wid2			
					obj->size->len=arg1->len
					obj->size->wid=arg1->wid
				}
			)
			
			(arg4
				{
					obj->size->len=arg1
					obj->size->wid=arg2
					obj->size->wid1=arg3
					obj->size->wid2=arg4
				}
			)
			
			(arg3
				{
					obj->size->len=arg1
					obj->size->wid=arg2
					obj->size->wid1=arg3
					obj->size->wid2=arg3
				}
			)
			
			(arg2
				{
					obj->size->len=arg1
					obj->size->wid=arg1
					obj->size->wid1=arg2
					obj->size->wid2=arg2
				}
			)
			
			(arg1
				{
					obj->size->wid1=arg1
					obj->size->wid2=arg1
				}
			)
			
			(t
				return -1
			)
		)
	)
)

procedure(_extend_rring_(obj len @optional (arg1 nil) (arg2 nil) (arg3 nil))
	let(
		(ref)
		ref=obj->ref
		changeRef(obj CENT)
		
		if((arg1&DIR_X)!=0 then 
			if((arg2&EXT)!=0
				then
					obj->size->len=obj->size->len+len*2
					obj->size->wid1=obj->size->wid1+len
			);if
			
			if((arg2&INT)!=0
				then
					obj->size->wid1=obj->size->wid1+len
			);if
		);if
		
		if((arg1&DIR_Y)!=0 then 
			if((arg2&EXT)!=0
				then
					obj->size->wid=obj->size->wid+len*2
					obj->size->wid2=obj->size->wid2+len
			);if
			
			if((arg2&INT)!=0
				then
					obj->size->wid2=obj->size->wid2+len
			);if
		);if
		
		
		obj->pattern->refresh(obj)
		changeRef(obj ref)
	)
)

procedure(_shrink_rring_(obj len @optional (arg1 nil) (arg2 nil) (arg3 nil))
	let(
		(ref)
		ref=obj->ref
		changeRef(obj CENT)
		
		if((arg1&DIR_X)!=0 then 
			if((arg2&EXT)!=0
				then
					obj->size->len=obj->size->len-len*2
					obj->size->wid1=obj->size->wid1-len
			);if
			
			if((arg2&INT)!=0
				then
					obj->size->wid1=obj->size->wid1-len
			);if
		);if
		
		if((arg1&DIR_Y)!=0 then 
			if((arg2&EXT)!=0
				then
					obj->size->wid=obj->size->wid-len*2
					obj->size->wid2=obj->size->wid2-len
			);if
			
			if((arg2&INT)!=0
				then
					obj->size->wid2=obj->size->wid2-len
			);if
		);if
		
		obj->pattern->refresh(obj)
		changeRef(obj ref)
	)
)

;########################################################
;	Graphic method
;########################################################

procedure(_draw_rring_(obj)
	prog(
		()
		if(obj->mat then
		obj->cc_id=dbCreatePolygon(obj->lyt->view_ID list(obj->mat "drawing") list(	obj->lbpos->x+obj->size->wid1	:	obj->lbpos->y+obj->size->wid2
												obj->rbpos->x-obj->size->wid1	:	obj->rbpos->y+obj->size->wid2
												obj->rtpos->x-obj->size->wid1	:	obj->rtpos->y-obj->size->wid2
												obj->ltpos->x+obj->size->wid1	:	obj->ltpos->y-obj->size->wid2
												obj->lbpos->x+obj->size->wid1	:	obj->lbpos->y
												obj->lbpos->x		     	:	obj->lbpos->y
												obj->ltpos->x			:	obj->ltpos->y
												obj->rtpos->x			:	obj->rtpos->y
												obj->rbpos->x			:	obj->rbpos->y
												obj->lbpos->x+obj->size->wid1	:	obj->lbpos->y
												obj->lbpos->x+obj->size->wid1	:	obj->lbpos->y+obj->size->wid2
											)
						)
		)
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

procedure(_create_contact_rring_(obj conf @optional (arg1 TOP|BOT|RT|LT))
	let(
		(iL iW w_c s_c cfg)
		
		w_c=conf->size
		s_c=conf->space
		
		if((arg1&TOP)!=0 then
			cfg=copy_ctCfg(conf)
			cfg->iX=obj->ltpos->x+obj->size->wid1
			cfg->iY=obj->ltpos->y-obj->size->wid2
			iL=obj->size->len-obj->size->wid1*2
			iW=obj->size->wid2	
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
		);if
		
		if((arg1&BOT)!=0 then
			cfg=copy_ctCfg(conf)
			cfg->iX=obj->lbpos->x+obj->size->wid1
			cfg->iY=obj->lbpos->y
			iL=obj->size->len-obj->size->wid1*2
			iW=obj->size->wid2	
			cfg->nX=round((iL-s_c)/(w_c+s_c))
			cfg->nY=round((iW-s_c)/(w_c+s_c))

			if(cfg->nX==0
				then 	cfg->nX=1
					cfg->offset1=(iL-w_c)/2
				else
					cfg->offset1=(iL-(w_c+s_c)*cfg->nX+s_c)/2
			);if

			if(cfg->nY==0
				then 	cfg->n_Y=1
					cfg->offset2=(iW-w_c)/2
				else
					cfg->offset2=(iW-(w_c+s_c)*cfg->nY+s_c)/2
			);if

		
			obj->ct_list=append1(obj->ct_list cfg)		
		);if
		
		if((arg1&LT)!=0 then
			cfg=copy_ctCfg(conf)
			cfg->iX=obj->lbpos->x
			cfg->iY=obj->lbpos->y+obj->size->wid2
			iL=obj->size->wid1
			iW=obj->size->wid-obj->size->wid2*2	
			cfg->nX=round((iL-s_c)/(w_c+s_c))
			cfg->nY=round((iW-s_c)/(w_c+s_c))

			if(cfg->nX==0
				then 	cfg->nX=1
					cfg->offset1=(iL-w_c)/2
				else
					cfg->offset1=(iL-(w_c+s_c)*cfg->nX+s_c)/2
			);if

			if(cfg->nY==0
				then 	cfg->n_Y=1
					cfg->offset2=(iW-w_c)/2
				else
					cfg->offset2=(iW-(w_c+s_c)*cfg->nY+s_c)/2
			);if

		
			obj->ct_list=append1(obj->ct_list cfg)		
		);if
		
		if((arg1&RT)!=0 then
			cfg=copy_ctCfg(conf)
			cfg->iX=obj->rbpos->x-obj->size->wid1
			cfg->iY=obj->rbpos->y+obj->size->wid2
			iL=obj->size->wid1
			iW=obj->size->wid-obj->size->wid2*2	
			cfg->nX=round((iL-s_c)/(w_c+s_c))
			cfg->nY=round((iW-s_c)/(w_c+s_c))

			if(cfg->nX==0
				then 	cfg->nX=1
					cfg->offset1=(iL-w_c)/2
				else
					cfg->offset1=(iL-(w_c+s_c)*cfg->nX+s_c)/2
			);if

			if(cfg->nY==0
				then 	cfg->n_Y=1
					cfg->offset2=(iW-w_c)/2
				else
					cfg->offset2=(iW-(w_c+s_c)*cfg->nY+s_c)/2
			);if

		
			obj->ct_list=append1(obj->ct_list cfg)		
		);if
	)
)


rring=make_patternObj(
			?name		"rectRing"
			?type		"pattern"
			?init		'_init_rring_
			?refresh 	'_refresh_rring_
			?getPos		'_getPos_
			?setPos		'_setPos_
			?move		'_move_rring_
			?changeRef	'_changeRef_
			?getPoint	'_getPoint_
			?getSize	'_getSize_rring_
			?setSize	'_setSize_rring_
			?extend		'_extend_rring_
			?shrink		'_shrink_rring_
			?delete		'_delete_rring_
			?clear		'_clear_
			?draw		'_draw_rring_
			?makeContact	'_create_contact_rring_
			
			
			?writeParser	'_writePs_
			?endParser	'_endPs_
)
