procedure(createSOBJ(pat @optional (template nil) (name nil) (mat nil))
	prog((inst)

		cond(
			(defstructp(template 'ccObj)
				{
					inst=make_ccObj(
						?name name
						?pos copy_posObj(template->pos)
						?ref template->ref
						?pattern pat
						?mat	mat
						?cc_id	nil
						?anchor template->anchor
						?son	nil
						?lyt	template->lyt
						?ltpos copy_posObj(template->ltpos)
						?lbpos copy_posObj(template->lbpos)
						?rtpos copy_posObj(template->rtpos)
						?rbpos copy_posObj(template->rbpos)
						?ctpos copy_posObj(template->ctpos)
						?cbpos copy_posObj(template->cbpos)
						?rcpos copy_posObj(template->rcpos)
						?lcpos copy_posObj(template->lcpos)
						?cpos copy_posObj(template->ctpos)
						?visible t
					)
					init(inst)
					setSize(inst template)
				}
			)
			
			(defstructp(template 'lytObj)
				{
					inst=make_ccObj(
						?name name
						?pos make_posObj(?x 0 ?y 0)
						?ref CENT
						?pattern pat
						?mat	mat
						?cc_id	nil
						?anchor nil
						?son	nil
						?lyt	template
						?ltpos make_posObj(?x 0 ?y 0)
						?lbpos make_posObj(?x 0 ?y 0)
						?rtpos make_posObj(?x 0 ?y 0)
						?rbpos make_posObj(?x 0 ?y 0)
						?ctpos make_posObj(?x 0 ?y 0)
						?cbpos make_posObj(?x 0 ?y 0)
						?rcpos make_posObj(?x 0 ?y 0)
						?lcpos make_posObj(?x 0 ?y 0)
						?cpos make_posObj(?x 0 ?y 0)
						?visible t
					)
					init(inst)
					refresh_ccOBJ(inst)
					bindUp(inst template)
				}
			)
			
			(t
				{
					inst=make_ccObj(
						?name name
						?pos make_posObj(?x 0 ?y 0)
						?ref CENT
						?pattern pat
						?mat	mat
						?cc_id	nil
						?anchor nil
						?son	nil
						?ltpos make_posObj(?x 0 ?y 0)
						?lbpos make_posObj(?x 0 ?y 0)
						?rtpos make_posObj(?x 0 ?y 0)
						?rbpos make_posObj(?x 0 ?y 0)
						?ctpos make_posObj(?x 0 ?y 0)
						?cbpos make_posObj(?x 0 ?y 0)
						?rcpos make_posObj(?x 0 ?y 0)
						?lcpos make_posObj(?x 0 ?y 0)
						?cpos make_posObj(?x 0 ?y 0)
						?visible t
					)
					init(inst)
					refresh_ccOBJ(inst)
				}
			)
		);cond
		
		return(inst)
	)
)

procedure(createLytOBJ(libname cellname)
	prog((lyt_inst)
		lyt_inst=make_lytObj(
				?lib_Name libname
				?cell_Name cellname
				?son	nil
		)
		lyt_init(lyt_inst)
		return(lyt_inst)
	)
)




