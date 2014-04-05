;########################################################
;	Pattern-independent method
;########################################################
;	these methods

procedure(setPosOrigin(obj x y)
	let(()
		if(defstructp(obj 'posObj) then
			obj->x=x
			obj->y=y
		else
			print("setPosOrigin failed : the first argument should be a posObj")
		)
	)
)

procedure(setvar(var_name var_value)
	let((sym_t)
		cond(
			(stringp(var_name)
				sym_t=stringToSymbol(var_name)
				set(sym_t var_value)
			)
			
			(symbolp(var_name)
				set(var_name var_value)
			)
		)
		
	)
)

;########################################################
;	Position method
;########################################################

procedure(getPos(obj)
	prog(()
		if(defstructp(obj 'ccObj)&&obj->pattern then
			return(obj->pattern->getPos(obj))
		else
			print("getPos failed : the first argument should be a ccObj with specified pattern")
		)
	)
)


procedure(setPos(obj arg1 @optional (arg2 nil))
	let(()
		if(defstructp(obj 'ccObj)&&obj->pattern then
			obj->pattern->setPos(obj arg1 arg2)
			obj->pattern->refresh(obj)
		else
			print("setPos failed : the first argument should be a ccObj with specified pattern")
		)	
	)
)


procedure(move(obj x y)
	let(()
		if(defstructp(obj 'ccObj)&&obj->pattern then
			obj->pattern->move(obj x y)
			obj->pattern->refresh(obj)
		else
			print("move failed : the first argument should be a ccObj with specified pattern")
		)
	)
)

procedure(translate(obj x y)
	let((i)
		if(defstructp(obj 'ccObj)&&obj->pattern then
			foreach(i obj->son
				if(i then
					translate(i x y)
				)
			)
			move(obj x y)
		else
			print("translate failed : the first argument should be a ccObj with specified pattern")
		)
	)
)

procedure(changeRef(obj ref)
	let(()
		if(defstructp(obj 'ccObj)&&obj->pattern then
			obj->pattern->changeRef(obj ref)
		else
			print("changRef failed : the first argument should be a ccObj with specified pattern")
		)
	)
)

procedure(getPoint(obj ref)
	prog(()
		if(defstructp(obj 'ccObj)&&obj->pattern then
			return(obj->pattern->getPoint(obj ref))
		else
			print("getPoint failed : the first argument should be a ccObj with specified pattern")
		)
	)
)


;########################################################
;	Size Modify method
;########################################################

procedure(getSize(obj)
	prog((size)
		if(defstructp(obj 'ccObj)&&obj->pattern then
			size=obj->pattern->getSize(obj)
			return(size)
		else
			print("getSize failed : the first argument should be a ccObj with specified pattern")
		)
	)
)


procedure(setSize(obj @optional (arg1 nil) (arg2 nil) (arg3 nil) (arg4 nil))
	let(
		()
		if(defstructp(obj 'ccObj)&&obj->pattern then
			obj->pattern->setSize(obj arg1 arg2 arg3 arg4)
			obj->pattern->refresh(obj)
		else
			print("setSize failed : the first argument should be a ccObj with specified pattern")
		)
	)
)


procedure(extend(obj @optional (arg1 nil) (arg2 nil) (arg3 nil) (arg4 nil))
	let(
		()
		if(defstructp(obj 'ccObj)&&obj->pattern then
			obj->pattern->extend(obj arg1 arg2 arg3 arg4)
			obj->pattern->refresh(obj)
		else
			print("extend failed : the first argument should be a ccObj with specified pattern")
		)	
	)
)


procedure(shrink(obj @optional (arg1 nil) (arg2 nil) (arg3 nil) (arg4 nil))
	let(
		()
		if(defstructp(obj 'ccObj)&&obj->pattern then
			obj->pattern->shrink(obj arg1 arg2 arg3 arg4)
		else
			print("shrink failed : the first argument should be a ccObj with specified pattern")
		)	
	)
)


;########################################################
;	Architecture method
;########################################################

procedure(setAnchor(obj_s obj_t)
	let(
		()
		if(defstructp(obj_s 'ccObj)&&defstructp(obj_t 'ccObj) then
			if(obj_s->anchor then
				removeAnchor(obj_s)
			)
			obj_s->lyt=obj_t->lyt
			obj_s->anchor=obj_t
			obj_t->son=append1(obj_t->son obj_s)
		else
			print("setAnchor failed : the first argument should be a ccObj with specified pattern")
		)
	)
)

procedure(removeAnchor(obj_s)
	let(
		(i)
		if(defstructp(obj_s 'ccObj) then
			obj_s->anchor->son=remove(obj_s obj_s->anchor->son)
			obj_s->anchor=nil			
		else
			print("removeAnchor failed : the first argument should be a ccObj with specified pattern")
		)
	)
)


procedure(setLyt(obj_s lyt_obj)
	let((i)
		cond(
			(defstructp(obj_s 'ccObj)&&defstructp(lyt_obj 'lytObj)
				{
					foreach(i obj_s->son 
						if(i then
							setLyt(i lyt_obj)
						)
					)
					obj_s->lyt=lyt_obj
				}
			)
			
			(defstructp(obj_s 'ccObj)&&defstructp(lyt_obj 'ccObj)
				{
					foreach(i obj_s->son 
						if(i then
							setLyt(i lyt_obj->lyt)
						)
					)
					obj_s->lyt=lyt_obj->lyt
				}
			)
			
			(t	print("setLyt failed : the arguments format should be (ccObj lytObj)")
			)
		)
	)
)

procedure(bindUp(obj_top lyt_obj)
	let((i)
		cond(
			(defstructp(obj_top 'ccObj)&&defstructp(lyt_obj 'lytObj)
				{
					lyt_obj->obj_to_draw=append1(lyt_obj->obj_to_draw obj_top)
					setLyt(obj_top lyt_obj)
				}
			)
			(t	
				print("bind failed : the arguments format should be (ccObj lytObj)")
			)
		)
	)
)

procedure(delete(obj)
	let(
		(i)
		if(defstructp(obj 'ccObj)&&obj->pattern then
			foreach(i obj->son
				if(i then
					delete(i)
				)
			) 
			clear_draw(obj)
			if(obj->anchor then 
				removeAnchor(obj)
				obj->anchor=nil
			)
			
			obj->pattern->delete(obj)	
		else
			print("delete failed : the first argument should be a ccObj with specified pattern")
		)	
	)
)

procedure(align(obj_s obj_t @optional (ref_p nil))
	let((pos_t)
		if(defstructp(obj_s 'ccObj)&&defstructp(obj_t 'ccObj) then
			if(ref_p then
				pos_t=case(ref_p
						(5 	obj_t->ltpos)
						(6 	obj_t->lbpos)
						(9 	obj_t->rtpos)
						(10 	obj_t->rbpos)
						(17	obj_t->ctpos)
						(18 	obj_t->cbpos)
						(24	obj_t->rcpos)
						(20 	obj_t->lcpos)
						(16 	obj_t->cpos)
						(t 	nil)
				);case
				print(pos_t->x)
				print(pos_t->y)
				setPos(obj_s pos_t)
				setAnchor(obj_s obj_t)	
			else
				pos_t=case(obj_s->ref
						(5 	obj_t->ltpos)
						(6 	obj_t->lbpos)
						(9 	obj_t->rtpos)
						(10 	obj_t->rbpos)
						(17	obj_t->ctpos)
						(18 	obj_t->cbpos)
						(24	obj_t->rcpos)
						(20 	obj_t->lcpos)
						(16 	obj_t->cpos)
						(t 	nil)
				);case
				setPos(obj_s pos_t)
				setAnchor(obj_s obj_t)
			)
		else
			print("align failed : the first argument should be a ccObj with specified pattern")
		)
	)
)

procedure(traverse(obj detectFun actFun)
	let(
		(i)
		if(defstructp(obj 'ccObj)&&detectFun(obj) then
			foreach(i obj->son
				if(i then
					traverse(i detectFun actFun)
				)
			)
			actFun(obj)
		)
	)
)

;########################################################
;	Pattern define method
;########################################################

procedure(init(obj)
	let(()
		if(defstructp(obj 'ccObj)&&obj->pattern then
			obj->pattern->init(obj)
		)
	)
)

procedure(setPattern(obj pat)
	let(()
		if(defstructp(obj 'ccObj) then
			if(defstruct(pat 'ccObj) then
				obj->pattern=pat->pattern
			else	if(defstruct(pat 'patternObj) then
					obj->pattern=pat
				)
			)
			obj->pattern->init(obj)
		else
			print("setMat failed : the first argument should be a ccObj with specified pattern")
		)
	)
)
;########################################################
;	Material Modify method
;########################################################

procedure(setMat(obj mat)
	let(()
		if(defstructp(obj 'ccObj) then
			if(defstructp(mat 'ccObj) then
				obj->mat=mat->mat
			else
				obj->mat=mat
			)
		else
			print("setMat failed : the first argument should be a ccObj with specified pattern")
		)
	)
)

;########################################################
;	Graphic method
;########################################################

procedure(enable(obj)
	let(()
		if(defstructp(obj 'ccObj)
			then 
				obj->visible=nil
		)
	)
)

procedure(disable(obj)
	let(()
		if(defstructp(obj 'ccObj)
			then 
				obj->visible=t
		)
	)
)

procedure(enableArc(obj)
	let((i)
		if(defstructp(obj 'ccObj)
			foreach(i obj->son
				enableArc(obj)
			)
			enable(obj)
		)
	)
)

procedure(disableArc(obj)
	let((i)
		if(defstructp(obj 'ccObj)
			foreach(i obj->son
				disableArc(obj)
			)
			disable(obj)
		)
	)
)


procedure(clear_draw(obj)
	let(
		(i)
		if(defstructp(obj 'ccObj)&&obj->pattern&&obj->son then
			foreach(i obj->son
				clear_draw(i)
			)
			obj->pattern->clear(obj)
		)
	)
)

procedure(draw(obj)
	let(
		(i)

		clear_draw(obj)

		cond(
			(defstructp(obj 'ccObj)
				{
					foreach(i obj->son
						if(i then
							draw(i)
							
						)
					)
					if(obj->visible then
						obj->pattern->draw(obj)
					)
				}
			)
			
			(defstructp(obj 'lytObj)
				{
					foreach(i obj->obj_to_draw
						if(i then
							draw(i)
						)
					)
				}
			)
			
			(t t)
			
		)
		
	)
)

procedure(drawPat(obj)
	let(
		(i)
		(defstructp(obj 'ccObj)
			obj->pattern->draw(obj)
		)
	)
)

;########################################################
;	Other method
;########################################################

procedure(defineContact(Mat size spac)
	prog((config)
		config=make_ctCfg()
		config->type="contact"
		config->mat=Mat
		config->size=size
		config->space=spac
		
		return(config)
	)
)

procedure(makeContact(inst cfg @optional (arg1 nil))
	let(()
		inst->pattern->makeContact(inst cfg arg1);
	)
)
procedure(refresh_ccOBJ(inst)
	let(()
		if(defstructp(inst 'ccObj)&&inst->pattern then
			inst->pattern->refresh(inst)
		)
	)
)


;##########################################################################
;##########################################################################
;#		layout function
;##########################################################################
;##########################################################################

procedure(lyt_init(lyt)
	let(()
		if(defstructp(lyt 'lytObj) then
			if(lyt->cell_Name&&lyt->lib_Name then
				lyt->view_ID=dbOpenCellViewByType(lyt->lib_Name lyt->cell_Name "layout" "maskLayout" "a")
			)
		)
	)
)

procedure(lyt_save(lyt)
	let(()
		if(defstructp(lyt 'lytObj) then
			dbSave(lyt->view_ID)
		)
	)
)

procedure(lyt_close(lyt)
	let(()
		if(defstructp(lyt 'lytObj) then
			dbClose(lyt->view_ID)
		)
	)
)




;##########################################################################
;##########################################################################
;#		File control function
;##########################################################################
;##########################################################################

procedure(save_to_file(obj file_name)
	let(()
		println("")
	)
)

procedure(read_from_file(file_name)
	prog(()
		return nil
	)
)

procedure(saveParser(obj file level)
	prog((i)
		if(defstructp(obj 'ccObj)&&obj->pattern then
			obj->pattern->writeParser(obj file level)
			foreach(i obj->son
				if(i then
					saveParser(i file level+1)
				)
			)
			obj->pattern->endParser(obj file level)
		else
			print("translate failed : the first argument should be a ccObj with specified pattern")
		)
	)
)
