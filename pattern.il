;########################################################
;	Position method
;########################################################

;##		default implementing method for patternObj::getPos interface
;##		allowed parameter:	getPos(ccObj)

procedure(_getPos_(obj)
	prog(
		()
		cond(
			(defstructp(obj->pos 'posObj)
				return(copy_posObj(obj->pos))
			)
			
			(t
				error("_getPos_ failed: invalid pos value in obj")
			)
		)
	)
)

;##		default implementing method for patternObj::setPos interface
;##		allowed parameter:	setPos(ccObj val_x val_y)
;##					setPos(ccObj ccObj)

procedure(_setPos_(obj arg1 @optional arg2)
	let(
		()
		cond(
			(arg2 
				{
					obj->pos->x=arg1
					obj->pos->y=arg2
				}
			)
			
			(defstructp(arg1 'posObj)
				{
					obj->pos->x=arg1->x
					obj->pos->y=arg1->y
				}
			)
			
			(defstructp(arg1 'ccObj)
				{
					obj->pos->x=arg1->pos->x
					obj->pos->y=arg1->pos->y
				}
			)
			
			(t
				nil
			)
		)
	)
)

;##		default implementing method for patternObj::move interface
;##		allowed parameter:	move(ccObj val_x val_y)

procedure(_move_(obj x y)
	let(
		()
		obj->pos->x=obj->pos->x+x
		obj->pos->y=obj->pos->y+y
	)
)

;##		default implementing method for patternObj::changeRef interface
;##		allowed parameter:	changeRef(ccObj string)

procedure(_changeRef_(obj ref)
	let(
		(flag)
		flag=t
		if(obj->pos&&obj->ref then
			obj->pos=case(ref
				(5 	obj->ltpos)
				(6 	obj->lbpos)
				(9 	obj->rtpos)
				(10 	obj->rbpos)
				(17	obj->ctpos)
				(18 	obj->cbpos)
				(24	obj->rcpos)
				(20 	obj->lcpos)
				(16 	obj->cpos)
				(t 	flag=nil)
			);case
			
			if(flag then 
				obj->ref=ref
			else
			println("error: invalid ref")
			)
			
		
		else
			println("get Point failed")
			println("error: the object is not a valid ccObj")
		);if
	)
)

;##		default implementing method for patternObj::getPoint interface
;##		allowed parameter:	getPoint(ccObj string)

procedure(_getPoint_(obj ref)
	prog(
		(ppos)
		cond(
			(obj->pos&&obj->ref
				{
					ppos=case(ref
						(5 	obj->ltpos)
						(6 	obj->lbpos)
						(9 	obj->rtpos)
						(10 	obj->rbpos)
						(17	obj->ctpos)
						(18 	obj->cbpos)
						(24	obj->rcpos)
						(20 	obj->lcpos)
						(16 	obj->cpos)
						(t 	flag=nil)
					);case

					if(ppos
						then return(ppos)
					else
						println("get Point failed")
						println("error : wrong argument of 'ref'")
					);if
				}
			)
			
			(t
				{
					println("get Point failed")
					println("error: the object is not a valid ccObj")
					return(nil)
				}
			)
		)
	)
)

;########################################################
;	Graphic method
;########################################################

;##		default implementing method for patternObj::clear interface
;##		allowed parameter:	clear(ccObj)

procedure(_clear_(obj)
	let(
		(i)
		if(obj->cc_id then 
			dbDeleteObject(obj->cc_id)
			if(obj->ct_id then
				foreach(i obj->ct_id
					dbDeleteObject(i)
				)
			)
		)
		obj->cc_id=nil
		obj->ct_id=nil
	)
)


;########################################################
;	Other method
;########################################################

;##		default implementing method for patternObj::refresh interface
;##		allowed parameter:	refresh(ccObj)

procedure(_refresh_(inst)
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
		
		if(inst->ct_list
			then
				iL=inst->size->len
				iW=inst->size->wid
				
				foreach(i inst->ct_list
				
					w_c=i->size
					s_c=i->space
					
					i->iX=obj->lbpos->x
					i->iY=obj->lbpos->y
					
					i->nX=round((iL-s_c)/(w_c+s_c))
					i->nY=round((iW-s_c)/(w_c+s_c))

					if(i->nX==0
						then 	i->nX=1
							i->offset1=(iL-w_c)/2
						else
							i->offset1=(iL-(w_c+s_c)*i->nX+s_c)/2
					);if

					if(i->n_Y==0
						then 	i->n_Y=1
							i->offset2=(iW-w_c)/2
						else
							i->offset2=(iW-(w_c+s_c)*i->nY+s_c)/2
					);if
				);foreach

		)
	)
)

;##		default implementing method for patternObj::writeParser interface
;##		allowed parameter:	writeParser(ccObj port int)

procedure(_writePs_(obj file level)
	let((i)
		for(i 1 level 
			fprintf(file "\t")
		)

		fprintf(file "<%s name=%L material=%L x=%L y=%L length=%L width=%L>\n" obj->pattern->name obj->name obj->mat obj->lbpos->x obj->lbpos->y obj->size->len obj->size->wid)
	)
)

;##		default implementing method for patternObj::endParser interface
;##		allowed parameter:	endParser(ccObj port int)

procedure(_endPs_(obj file level)
	let((i)
		for(i 1 level 
			fprintf(file "\t")
		)
		
		fprintf(file "</%s>\n" obj->pattern->name)
	)
)





;########################################################
;	structure define
;########################################################
defstruct(patternObj
		; object info
		name						; Name of the patternObj instance. this would be used as the tag in XML document: string
				
		type						; Type of the patternObj object. The static value for it is "pattern": string
		
		cfg						; Config Information
		
		; layout modification method
		init						; Interface for patternObj initializing.
								; The basic function of this interface is generate different size object for a ccObj instance.
								; Besides, you can still use it for other purposes.
								; Implements of this interface will be called in the creating function:
								;	init(ccObj)
								
		refresh						; Updating inner values for ccObj instance.
								; A default implement for this _refresh_ only update size and position info.
								; It would be called automatically in size-position-related method.
								;	refresh(ccObj)
								
		getPos						; To get the position information of a ccObj instance
								; The return value for this interface should be a size object for its patterObj
								;	getPos(ccObj)
								
		setPos						; To set the position information of a ccObj instance
								; This interface support overload : you can set the position from a list of value or copy the corresponding information from another ccObj
								;	setPos(ccObj val1 ...) or setPos(ccObj ccObj)
								
		move						; To move a ccObj
								; This move act should be independent from its parent or son object.
								;	move(ccObj val_x val_y)
								
		changeRef					; Changing the reference point of a ccObj
								; The supported values for reference points inlucde ("lb",20,5,"cb",16,"ct","rb",24,9)
								;	changeRef(ccObj s_ref)
								
		getPoint					; To get a special point according to the ref parameter
								;	getPoint(ccObj s_ref)
								
		getSize						; To get the size information of a ccObj instance.
								; The type of size is a object defined in the pattern.
								;	getSize(ccObj)
								
		setSize						; To set Size information of a ccObj instance
								; This is a overload inteface, too.
								; A length of 4 extra values is available to define your size freely.
								;	setSize(ccObj ccObj) or setSize(ccObj (arg1) (arg2) (arg3) (arg4))
								
		extend						; To extend your sharp in a given value
								; Except width and length,2 extra values are optional for this interface.
								;	extend(ccObj len wid (arg1) (arg2))
								
		shrink						; Similar to extend method
		
		makeContact					; createContact

		; graphics method
		delete						; Delete object
		draw						; Draw the object
		clear						; Clear the draw

		; file method
		writeParser					; To write the information in a xml format
								; writeParser(ccObj port level)
								
		endParser					; To finish the parser
								; endParser(ccObj port level)
								
		;; reversed interface				; These un-realized interface will be supported in the next version of lytlib
		save
		load
		cheak
		collide
		isCollide
)
