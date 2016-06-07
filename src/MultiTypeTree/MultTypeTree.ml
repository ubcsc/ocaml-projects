(***********************************************************************************
 * Project title: Multi-type Tree Node editing								       *
 *                                                                                 *
 * Purpose:  To create a Binary tree that can hold values of different Types       *
 * 			 whereby editing of the Nodes could be possible depending on the       *
 *			 type of Node it is therefor functions are to be created that effect   *
 *			 the change on each particular type of Node                            *
 *           the functions are to be stored in a table that is for each type you   *
 *           have all the functions(operations) that can be peformed on them       *
 *                                                                                 *
 * Author's Detail:                                                                *
 *			Ngoulla Sob Christian Arsnel     SC14A884                              *
 *			Kefeh Collins Yunyuy             SC14B365                              *
 *			Chawa Fabu  Elcid  Chawa         SC14A242                              *
 *			Nwafor Happi Yvan                SC14B375                              *
 ************************************************************************************)

module MultTypeTree : sig 
	type course = {
		title : string;
		code: string;
	}
	type book = {
		title: string;
		author: string;
		number_pages: int;
	}
	type lec =  {
		security_number: string;
		fname: string;
		lname: string;
	}
	type stu = {
		matricule: string;
		first_name: string;
		last_name: string;
	}

(*diffType is just a variant of all the types already created and can be used from hear difftype also helps 
		us created created functions that can take alternative types we have created so far*)

	type diffType = 
		| Lecturer of lec
		| Student of  stu
		| Book of book
		| Course of course

(*The type relwithParent is a type created with predefined relationships to chosse from depending on the type and 
		the relationship they can share*)

	type relWithParent = 
		| NoRelation | Istaught | Assistantof | WorkOnAproject | Teaches | IsTakenBy
    	| Colleagues | ClassMates | WrittenBy | RecommendedBy | IstaughtBy | SameDept
		| UseTheBook | SameSubject | UseBy | WroteThe | TakeTheCourse | UseForTheCourse

(*the type other is an optional additional info that can be added to a node just when needed to tell much about the node*)

	type other = { 
  		mutable rel: relWithParent; 
  		logicParent: string*string;
  		type_ : bool; 
  	}

 (*'a multree is the name of the binary multy-type tree we are creating *)

  	type 'a multree_ = 
		| Leaf
		| Node of 'a * other* 'a multree_ * 'a multree_
		
	type 'a type_func = 
 		| Function_2 of ('a -> string*string -> relWithParent -> 
 			'a multree_  -> 'a multree_)
 		| Function_1 of ('a -> diffType multree_ -> relWithParent ->
 			 bool -> string * string -> diffType multree_ )
 		| Function_3 of (string*string -> 'a multree_ -> 'a multree_)
 		| Function_4 of ('a multree_ -> 'a multree_ -> 'a multree_)
 		| Function_5 of (string*string -> 'a multree_ -> int)
 		| Function_6 of 
 			( string*string -> 
 			string option * string option * string option -> 
 			'a  multree_ -> 'a multree_)
 		| Function_7 of (diffType * diffType -> int )
 		| Function_8 of (diffType -> string * string)
 		| Function_9 of (diffType -> int)
 		| Function_10 of (diffType multree_ -> int )
 		| Function_11 of (int -> relWithParent -> bool)
 		| Function_12 of 
 			 (string * string -> string * string ->
			 diffType multree_ -> diffType multree_ -> diffType multree_)
 		| Function_13 of 
 			( string*string -> 
 			string option * string option  -> 
 			'a  multree_ -> 'a multree_)

	val functions_1: ( int , diffType type_func ) Hashtbl.t 

	val functions_2 : ( int, diffType type_func ) Hashtbl.t

	val functions_3 : ( int, diffType type_func ) Hashtbl.t

	val functions_4 : ( int, diffType type_func ) Hashtbl.t

	val general_purpose_func : ( int, diffType type_func ) Hashtbl.t

	val functions : ( int, ((int, diffType type_func ) Hashtbl.t ) ) Hashtbl.t

	val dummy_node: diffType multree_

	val init :  unit -> unit 

	val relation : diffType * diffType -> int 

	val getSomeInfo : diffType -> string * string
	
	val getLabel : diffType -> int 
	
	val empty : 'a multree_ -> int 

	val insert : 
		diffType -> diffType multree_ -> 
		relWithParent -> 
		bool -> string * string -> diffType multree_
	
	val relation_mapping: int -> relWithParent -> bool
	
	val insert_rel : 
		diffType -> string * string ->
		relWithParent -> diffType multree_ -> diffType multree_
	
	val addNode : 
		'a multree_ -> 'a multree_ -> 'a multree_
	
	val modfNode: 
		string * string -> string * string ->
		diffType multree_ -> diffType multree_
	
	val addNodeModf : 
		string * string -> string * string ->
		diffType multree_ -> diffType multree_ -> diffType multree_
	
	val getTheNodeLabel : 
		string * string -> diffType multree_ -> int
	
	val delete : 
		string * string -> diffType multree_ -> diffType multree_
	
	val delete_course:
		string * string -> diffType multree_ -> diffType multree_
	
	val delete_lecturer : 
		string * string -> diffType multree_ -> diffType multree_
	
	val insert_lec_info :
		string * string -> diffType multree_ * diffType multree_ -> 
		diffType multree_ -> diffType multree_
	
	val delete_student :
	    string * string -> diffType multree_ -> diffType multree_
	
	val delete_book: 
	    string * string -> diffType multree_ -> diffType multree_
	
	val	delete_all:
	    string * string -> diffType multree_ -> diffType multree_
	
	val delete_cons:
	    string * string -> diffType multree_ -> diffType multree_
	
	val extract:
	    string * string -> diffType multree_ -> 
	    diffType multree_* diffType multree_
	
	val replace_node :
	    string * string -> diffType multree_ ->
	    diffType multree_ -> diffType multree_
	
	val getString: 
		string option -> string -> string 

	val mutate_lec_keys:  
		string option * string option * string option -> diffType ->
		diffType 

	val mutate_stu_keys:  
		string option * string option * string option -> diffType ->
		diffType 

	val mutate_cou_keys:  
		string option * string option  -> diffType ->
		diffType 
	
	val mutate_book_keys:  
		string option * string option * string option -> diffType ->
		diffType 

	val update_info:
		string * string -> string * string -> diffType multree_ -> diffType multree_ 

	val edit_a_lecturer: 
		string * string -> string option*string option*string option ->
		diffType multree_ -> diffType multree_

	val edit_a_student: 
		string * string -> string option*string option*string option ->
		diffType multree_ -> diffType multree_

	val edit_a_course: 
		string * string -> string option*string option ->
		diffType multree_ -> diffType multree_	

	val edit_a_book: 
		string * string -> string option*string option*string option ->
		diffType multree_ -> diffType multree_	

	val edit:  string*string -> string option*string option*string option -> diffType multree_
						-> diffType multree_

	val getRelation: string -> relWithParent

	val getOptionString: unit -> string option

	val func_modification: diffType type_func -> unit 

	val create : unit -> diffType 

	val run :  diffType multree_-> diffType multree_ 

	end = struct 
	type course = {
		title : string;
		code: string;
	}
	type book = {
		title: string;
		author: string;
		number_pages: int;
	}
	type lec =  {
		security_number: string;
		fname: string;
		lname: string;
	}
	type stu = {
		matricule: string;
		first_name: string;
		last_name: string;
	}
	type diffType = 
		| Lecturer of lec
		| Student of  stu
		| Book of book
		| Course of course
	type relWithParent = 
		| NoRelation | Istaught | Assistantof | WorkOnAproject | Teaches | IsTakenBy
    	| Colleagues | ClassMates | WrittenBy | RecommendedBy | IstaughtBy | SameDept
		| UseTheBook | SameSubject | UseBy | WroteThe | TakeTheCourse | UseForTheCourse
	type other = { 
  		mutable rel: relWithParent; 
  		logicParent: string*string;
  		type_ : bool; 
  	}
  	type 'a multree_ = 
		| Leaf
		| Node of 'a * other* 'a multree_ * 'a multree_ 

	type 'a type_func = 
 		| Function_2 of ('a -> string*string -> relWithParent -> 
 			'a multree_  -> 'a multree_)
 		| Function_1 of ('a -> diffType multree_ -> relWithParent ->
 			 bool -> string * string -> diffType multree_ )
 		| Function_3 of (string*string -> 'a multree_ -> 'a multree_)
 		| Function_4 of ('a multree_ -> 'a multree_ -> 'a multree_)
 		| Function_5 of (string*string -> 'a multree_ -> int)
 		| Function_6 of 
 			( string*string -> 
 			string option * string option * string option -> 
 			'a  multree_ -> 'a multree_)
 		| Function_7 of (diffType * diffType -> int )
 		| Function_8 of (diffType -> string * string)
 		| Function_9 of (diffType -> int)
 		| Function_10 of (diffType multree_ -> int )
 		| Function_11 of (int -> relWithParent -> bool)
 		| Function_12 of 
 			 (string * string -> string * string ->
			 diffType multree_ -> diffType multree_ -> diffType multree_)
 		| Function_13 of 
 			( string*string -> 
 			string option * string option  -> 
 			'a  multree_ -> 'a multree_)

(*here we are creating hashtables for the different existing types and for the general purpose functions existing already
	the hashtables for the types are in order to hold operations (funtions) permissible on that type only then one other Hash table
	Named Functions that hold all the other hashtables*)

	let functions = Hashtbl.create 10
	let functions_4 = Hashtbl.create 10
	let functions_3 = Hashtbl.create 10
	let functions_2 = Hashtbl.create 10
	let functions_1 = Hashtbl.create 10
	let general_purpose_func = Hashtbl.create 10
	let dummy_node = Leaf

(*the Function relation takes two types and returns an iterger it compares the types to the types already created and if a  pssib
le relationship can be established it returns a number this number will be used in later functions*)
 	let relation (e:diffType*diffType) :int = 
		let (element1, element2 ) = e in
		match (element1, element2 ) with
			| ( Lecturer(element1), Lecturer(element2)) -> 1
			| ( Lecturer(element1), Student(element2)) -> 2
			| ( Student(element1), Lecturer(element2)) -> 3
			| ( Student(element1), Student(element2)) -> 4
			| ( Book(element1), Book(element2)) -> 5
			| ( Student(element1), Book(element2)) -> 6
			| ( Book(element1), Student(element2)) -> 7
			| ( Lecturer(element1), Book(element2)) -> 8
			| ( Book(element1), Lecturer(element2)) -> 9
			| ( Book(element1), Course(element2)) -> 10
			| ( Course(element1), Book(element2)) -> 11
			| ( Student(element1), Course(element2)) -> 12
			| ( Course(element1), Student(element2)) -> 13
			| ( Lecturer(element1), Course(element2)) -> 14
			| ( Course(element1), Lecturer(element2)) -> 15
			| ( Course(element1), Course(element2)) -> 16

(*the function getSomeinfo takes a diffType and returns a tuple of strings
	 which we use to identify the Node
	the pair varies according to the type of a node*)
	let getSomeInfo (e:diffType) :string*string = 
		match e with 
			| Lecturer(e) -> (e.fname, e.lname)
			| Student(e) -> (e.first_name, e.last_name)
			| Book(e) -> (e.title, "")
			| Course(e) -> ( e.title, e.code )

(*getLabel functions helps in identifying the type of a node
	 by returning a value perculiar to that type only*)	
	let getLabel (e:diffType) :int = 
		match e with
			| Lecturer(e) -> 1
			| Student(e) -> 2
			| Book(e) -> 3
			| Course(e) -> 4
(*empty is just to check if a  node is Empty or Not*)
	let empty e :int= 
		match  e with
		| Leaf -> 1
		| Node ( keys, o_info, left,  right) -> 2

(*Since relationships are perculiar to certain types mostly relation_mapping 
	function take an interger(from relation
	function) and a relationship and check if the relationship can apply to the types 
	mensioned then returns a boolean which either accepts (true) or denies(false) it*)
	let rec relation_mapping (val_of_relation:int ) (rel:relWithParent) :bool=
		match val_of_relation, rel with 
 	 		| ( 1, r ) when ( r = Colleagues || r = Assistantof || r = WorkOnAproject ) -> true 
 	 		| ( 2, r ) when ( r = Istaught|| r = Assistantof ) -> true
 	 		| ( 3, r ) when ( r = Teaches ) -> true
 	 		| ( 4, r ) when ( r = ClassMates || r = WorkOnAproject || r = Assistantof ) -> true
 	 		| ( 5, r ) when ( r = SameSubject ) -> true
 	 		| ( 6, r ) when ( r = UseBy ) -> true
 	 		| ( 7, r ) when ( r = UseTheBook ) -> true
			| ( 8, r ) when ( r = WrittenBy || r = RecommendedBy || r = UseBy ) -> true
			| ( 9, r ) when ( r = WroteThe || r = UseTheBook) -> true
			| ( 10, r ) when ( r = UseTheBook ) -> true
			| ( 11, r ) when ( r = UseForTheCourse ) -> true
			| ( 12, r ) when ( r = IsTakenBy ) -> true
			| ( 13, r ) when ( r = TakeTheCourse ) -> true
			| ( 14, r ) when ( r = IstaughtBy ) -> true
			| ( 15, r ) when ( r = Teaches ) -> true
			| ( 16, r ) when ( r = SameDept ) -> true
			| ( _, _ ) -> false 
	
(*the insert function does a simple insert on the tree when the relation has been approved*)
	let rec insert values root (relation:relWithParent)  (a:bool) (par:string*string) = 
		match root with 
			| Leaf ->  Node (values, { rel = relation; logicParent = par; type_ = a }, Leaf, Leaf); 
			| Node ( keys,o_info, left,  right ) ->
				if (empty left = 1) then Node ( keys ,o_info, insert values left relation  true par, right )
				else Node ( keys,o_info , left, insert values right  relation false par )
	
	(*The insert_rel function does alot, inserting according to type and
	 relationship and as well calling functions from the 
	hashtable (functions) like insert and relation_mapping rather than from the module*)
	let rec insert_rel (values:diffType) (target: string*string)  (rel: relWithParent ) root  = 
		match root with 
			| Leaf -> Leaf
			| Node ( keys,o_info, left,  right ) -> 
				if ( getSomeInfo keys )= target  then 
					let Function_11(func1) = (Hashtbl.find ( Hashtbl.find functions  5 ) 7) in  
				 	if ( (func1 (relation (keys, values)) rel) = true ) then  
			 			let Function_1 (func) = (Hashtbl.find ( Hashtbl.find functions 5 ) 1) in
 			 			func values root rel  true target
					else root
				else 
					let el = Node ( keys,o_info, (insert_rel values target  rel left), right ) in
					let el1 = Node ( keys,o_info, left, (insert_rel values target  rel right) ) in
					if el <> root then el
					else if el1 <> root then el1
					else  root

(*addNode adds an already created Node to the tree but it also adds a node to the 
	right node if the left and the right nodes
	are not leafs therefor the right node serve as a container to hold additional children of thier parent node*)
	let rec addNode node el = 
		match node with 
		| Leaf -> Leaf
		| Node ( keys, o_info, left, right ) -> 
			if left = Leaf then Node ( keys, o_info, el, right )
			else if right = Leaf then Node ( keys, o_info, left, el) 
			else  Node ( keys, o_info, left, (addNode right el) )

(*modfNode modifies the children of a node which has been edited by editing(updating) the children's logic parent name taking 
	as parameters target which is the valus of the old parent the info which is the updated information*)
	let rec modfNode (target: string*string) (info:string*string)  = function 
		| Leaf -> Leaf
		| Node ( keys, o_info, left, right ) ->
			if o_info.logicParent = target then 
	 			Node ( keys, { rel = o_info.rel; logicParent = info; type_ = o_info.type_},
	 			 modfNode target info  left, modfNode target info right )
	 		else   Node ( keys, o_info, modfNode target info left, modfNode target info right)
	

	let rec addNodeModf (target:string*string) (info:string*string) node1 node2 = 
		match node1 with 
		| Leaf -> Leaf
		| Node ( keys, o_info, left, right ) -> 
			if left = Leaf then Node ( keys, o_info, (modfNode target info  node2), right )
			else if right = Leaf then Node ( keys, o_info, left,(modfNode target info  node2) ) 
			else  Node ( keys, o_info, left, (addNodeModf target info right node2) )
	
(*the function getTheNodeLabel gets the label of the Node whose location is unknown by searching throughout the tree*)
	let rec getTheNodeLabel (target:string*string) = function
		| Node ( keys, _, left, right ) -> 
			if ( getSomeInfo keys ) = target then 
				getLabel keys
			else 
				let e = getTheNodeLabel target left in
				let t = getTheNodeLabel target right in
				if e <> (-1) then e else t
		| Leaf -> (-1)


(*the insert_lec_info function is used to insert information specific for a lecturer*)	
	let rec insert_lec_info (target:string*string) (elements: 'a multree_ * 'a multree_ ) = function 
		| Node ( keys, o_info, left, right ) as node -> 
			if ( getLabel keys = 1 ) then 
				let ( l, r ) = elements in
				addNodeModf target (getSomeInfo keys) ( addNodeModf target (getSomeInfo keys) node l ) r
			else 
				let e = Node ( keys, o_info, insert_lec_info target elements left, right ) in 
				let t = Node ( keys, o_info, left, insert_lec_info target elements right ) in
				if e <> node then e else t
		| Leaf -> Leaf
	
(*the function delete all deletes all the subtree of a specific node*)
	let rec delete_all ( target:string*string ) = function 
		| Node ( keys, o_info, left, right  ) as node -> 
			if ( getSomeInfo keys = target ) then 
				match ( left, right ) with
				| ( _, _ ) -> Leaf
			else 
				begin 
				let e = Node ( keys, o_info, delete_all target left, right) in
				let t = Node ( keys, o_info, left, delete_all target right) in
				if e <> node then e else t
				end
		| Leaf -> Leaf
	
(*this function delete_cons deletes a node but takes into consideration if the node has both
 left and right children the left children will be copied to the right conserving
  the Nodes subtree then deleting the node *)
  	let rec delete_cons (target:string*string) = function
		| Node ( keys, o_info, left, right  ) as node -> 
			if ( getSomeInfo keys = target ) then 
				match ( left, right ) with
					| ( Leaf, Leaf ) -> Leaf
					| ( left, Leaf ) -> left
					| ( Leaf, right) -> right
					| (_, _) -> addNode left right
			else 
				begin 
				let e = Node ( keys, o_info, delete_cons target left, right) in
				let t = Node ( keys, o_info, left, delete_cons target right) in
				if e <> node then e else t
				end
		| Leaf -> Leaf
	
(*the extract function returns a turple of nodes(children) from a given data of a parent node*)
	let rec extract ( target : string*string) = function 
		| Node ( keys, o_info, left, right ) -> 
			if ( getSomeInfo keys = target ) then ( left, right )
			else
				let e = extract target left in 
				let t = extract target right in 
				if e <> ( Leaf, Leaf ) then e else t
		| Leaf -> ( Leaf, Leaf )

(*delete_lecturer deletes specifically a lecturer but stores up its children in som other lecturers container node
	[erculiarly it is also does function calls from the hashtable and not from the module *)	
	let  delete_lecturer (target:string*string)  = function 
		| Node ( keys, o_info, left, right ) as node ->
			let elements = extract target node in 
			let Function_3(func) = (Hashtbl.find ( Hashtbl.find functions  5 ) 4) in

			insert_lec_info target elements ( func target node )
		| Leaf -> Leaf
	
(*delete_lecturer deletes specifically a lecturer but stores up its children in som other lecturers container node
	[erculiarly it is also does function calls from the hashtable and not from the module *)
	let delete_student ( target: string*string ) = function 
		| Node ( keys, o_info, left, right ) as node -> 
			let Function_3(func) = (Hashtbl.find ( Hashtbl.find functions  5 ) 4) in
			func target  node
		| Leaf -> Leaf
	

	let delete_book ( target: string*string ) = function 
		| Node ( keys, o_info, left, right ) as node ->
			let Function_3(func) = (Hashtbl.find ( Hashtbl.find functions  5 ) 5) in
	 		func target node
		| Leaf -> Leaf
	
(*the delete function is a generic function that calls a specific delete function for a particular type 
to effect the deleting*)
	let rec delete ( target:string*string )  = function  
		| Leaf -> Leaf
		| Node ( keys, o_info, left, right ) as node ->  
			match (getTheNodeLabel target node ) with 
				| 1 -> let Function_3(func) = (Hashtbl.find (Hashtbl.find functions 1 ) 1 ) in 
					func target node
				| 2 -> let Function_3(func) = (Hashtbl.find (Hashtbl.find functions 2 ) 1 ) in
					func target node 
				| 3 -> let Function_3(func) = (Hashtbl.find (Hashtbl.find functions 4 ) 1 ) in
					func target node
				| 4 -> let Function_3(func) = (Hashtbl.find (Hashtbl.find functions 3 ) 1 ) in
				 	func target node
				| _ -> node
	and delete_course ( target: string*string) = function 
		| Leaf -> Leaf
		| Node ( keys, o_info, left, right ) as node ->
			let elements = extract target node in
			let (l, r) = elements in
				match (l, r) with 
					| ( Leaf, Leaf ) -> 
						let Function_3(func) = (Hashtbl.find ( Hashtbl.find functions  5 ) 4) in
						func target node
					| ( Node(k, _, _, _), Leaf ) -> 
						let Function_3(func1) = (Hashtbl.find ( Hashtbl.find functions  5 ) 4) in  
						let Function_3(func2) = (Hashtbl.find ( Hashtbl.find functions  5 ) 3) in
						func1 target ( func2 ( getSomeInfo k) node )
					| ( Node( k, _, _, _ ), Node( k', _, _, _ ) ) -> 
						let Function_3(func1) = (Hashtbl.find ( Hashtbl.find functions  5 ) 4) in  
						let Function_3(func2) = (Hashtbl.find ( Hashtbl.find functions  5 ) 3) in
						func1 target ( func2 (getSomeInfo k) (func2 (getSomeInfo k') node ))
					| ( Leaf, Node(_, _, _, _) ) -> node
	

(*the function replace actually takes a tuple that identifies the target node, a node to replace the target node
and a tree to which the target Node is found*)
	let rec replace_node ( target:string*string ) node = function 
		| Node ( keys, o_info, left, right )  as anode -> 
			if ( getSomeInfo keys = target ) then 
				match  ( left, right) with
				| (_, _) -> node
			else 
				begin 
				let e = Node ( keys, o_info, replace_node target node left, right ) in
				let t = Node ( keys, o_info, left, replace_node target node right ) in 
				if e <> anode then e else t;
				end
		| Leaf -> Leaf
	

(*getString takes an optional string(from the user) and a string from a type to be updated and returns the string if the
optional string is not inputed or the optional string if it is inputed *)
	let getString (info:string option) (node_info:string) = 
		match info, node_info with 
			| None, str -> ""^str
			| Some x, str -> x


	
(*the mutate functions helps in editing it takes information and modifies the said node to the recent information*)
	let mutate_lec_keys (info1, info2, info3 ) (keys:diffType) =
		let Lecturer (l) = keys in
		let ( strInfo1, strInfo2, strInfo3 ) = 
			( getString info1 l.security_number, getString info2 l.fname, getString info3 l.lname ) in
		match keys with 
			| _ -> Lecturer ({security_number = strInfo1; fname = strInfo2;
					lname = strInfo3 } )

	let mutate_stu_keys (info1, info2, info3 ) (keys:diffType) =
		let Student (l) = keys in
		let ( strInfo1, strInfo2, strInfo3 ) = 
			( getString info1 l.matricule, getString info2 l.first_name, getString info3 l.last_name ) in
		match keys with 
			| _ -> Student ({matricule = strInfo1; first_name = strInfo2;
					last_name = strInfo3 } )
	
	let mutate_cou_keys (info1, info2 ) (keys:diffType) =
		let Course (l) = keys in
		let ( strInfo1, strInfo2 ) = 
			( getString info1 l.title, getString info2 l.code ) in
		match keys with  
			| _ -> Course ({title = strInfo1; code = strInfo2 } )

	let mutate_book_keys (info1, info2, info3 ) (keys:diffType) =
		let Book (l) = keys in
		let ( strInfo1, strInfo2, strInfo3 ) = 
			( getString info1 l.title, getString info2 l.author, getString info3  (string_of_int (l.number_pages )) ) in
		match keys with 
			| _ -> Book ({title = strInfo1; author = strInfo2;
					number_pages = (int_of_string (strInfo3)) } )
	

(*The update info function takes a Node and two tuples of string one having the information for the target Node and the other
 the information to update and then it updates the Node to the recent information*)
	let rec update_info (target:string*string) ( infos:string *string  )  =  function 
		| Node ( keys, o_info, left, right) ->  
			if (o_info.logicParent = target) then
				Node ( keys, {rel=o_info.rel; logicParent = infos; type_ = o_info.type_ },
				update_info target infos left, update_info target infos right )
			else
				Node ( keys, o_info, update_info target infos left, update_info target infos right)
		| Leaf -> Leaf
	
(*The edit functions work specifically for the types they specify(in thier name) they do so by checking and ensuring 
that the target is met and then it calls the suitable mutate and update function to do the updating*)
	let rec edit_a_lecturer (target:string*string) (infos:string option*string option*string option) = function 
		| Node ( keys, o_info, left, right ) as node ->
			if ( getSomeInfo keys ) = target then 
				let (info1, info2, info3 ) = infos in 
				let Lecturer(l) = keys in 
				update_info target ( (getString info2 l.fname) , 
					(getString info3 l.fname) ) (Node ( mutate_lec_keys (info1, info2, info3 ) keys,
					 o_info, left, right ))
			else 
				let e = Node ( keys, o_info, edit_a_lecturer target infos left, right ) in
				let t = Node ( keys, o_info, left, edit_a_lecturer target infos right ) in
				if e <> node then e else t
		| Leaf -> Leaf

	let rec edit_a_student (target:string*string) (infos:string option*string option*string option) = function 
		| Node ( keys, o_info, left, right ) as node ->
			if ( getSomeInfo keys ) = target then 
				let (info1, info2, info3 ) = infos in 
				let Student(l) = keys in 
				update_info target ( (getString info2 l.first_name) , 
					(getString info3 l.last_name) ) (Node ( mutate_stu_keys (info1, info2, info3 ) keys,
					 o_info, left, right ))
			else 
				let e = Node ( keys, o_info, edit_a_student target infos left, right ) in
				let t = Node ( keys, o_info, left, edit_a_student target infos right ) in
				if e <> node then e else t
		| Leaf -> Leaf

	let rec edit_a_course (target:string*string) (infos:string option*string option ) = function 
		| Node ( keys, o_info, left, right ) as node ->
			if ( getSomeInfo keys ) = target then 
				let (info1, info2 ) = infos in 
				let Course(l) = keys in 
				update_info target ( (getString info1 l.title) , 
					(getString info2 l.code) ) (Node ( mutate_cou_keys (info1, info2 ) keys,
					 o_info, left, right ))
			else 
				let e = Node ( keys, o_info, edit_a_course target infos left, right ) in
				let t = Node ( keys, o_info, left, edit_a_course target infos right ) in
				if e <> node then e else t
		| Leaf -> Leaf


	let rec edit_a_book (target:string*string) (infos:string option*string option*string option ) = function 
		| Node ( keys, o_info, left, right ) as node ->
			if ( getSomeInfo keys ) = target then 
				let (info1, info2, info3  ) = infos in 
				let Book(l) = keys in 
				update_info target ( (getString info1 l.title) , 
					(getString info2 l.author) ) (Node ( mutate_book_keys (info1, info2, info3 ) keys,
					 o_info, left, right ))
			else 
				let e = Node ( keys, o_info, edit_a_book target infos left, right ) in
				let t = Node ( keys, o_info, left, edit_a_book target infos right ) in
				if e <> node then e else t
		| Leaf -> Leaf


(*The edit function takes the target info, information to update with and the Node and tries to match it to a type when that
is successful it calls from the hashtable the best suitable edit function to effect the editing*)
	let edit (target:string*string ) (infos:string option*string option*string option ) = function 
		| Leaf -> Leaf 
		| Node ( keys, _, left, right ) as node ->
			let ( info1, info2, info3  ) = infos in  
			match ( getTheNodeLabel target node ) with 
				| 1 -> let Function_6(func) = (Hashtbl.find ( Hashtbl.find functions  1 ) 2) in
					func target (info1, info2, info3 ) node
				| 2 -> let Function_6(func) = (Hashtbl.find ( Hashtbl.find functions  2 ) 2) in
					func target (info1, info2, info3 ) node
				| 3 -> let Function_6(func) = (Hashtbl.find ( Hashtbl.find functions  4 ) 2) in
					func target (info1, info2, info3 ) node
				| 4 -> let Function_6(func) = (Hashtbl.find ( Hashtbl.find functions  3 ) 2) in
					func target (info1, info2, info3 ) node
				| _ -> node


(*Here we are now creating the Hashtables to be used *)
 	let init () =
 		begin
 		Hashtbl.add general_purpose_func 1 (Function_1(insert));
 		Hashtbl.add general_purpose_func 2 (Function_2(insert_rel));
 		Hashtbl.add general_purpose_func 3 (Function_3(delete));
 		Hashtbl.add general_purpose_func 4 (Function_3(delete_all));
 		Hashtbl.add general_purpose_func 5 (Function_3(delete_cons));
 		Hashtbl.add general_purpose_func 11 (Function_6(edit));

 		Hashtbl.add functions_1 1 (Function_3(delete_lecturer));
		Hashtbl.add functions_2 1 (Function_3(delete_student));
		Hashtbl.add functions_4 1 (Function_3(delete_book));
		Hashtbl.add functions_3 1 (Function_3(delete_course));
		Hashtbl.add functions_1 2 (Function_6(edit_a_lecturer));
		Hashtbl.add functions_2 2 (Function_6(edit_a_student));
		Hashtbl.add functions_4 2 (Function_6(edit_a_book));
		Hashtbl.add functions_3 2 (Function_13(edit_a_course));

 		Hashtbl.add general_purpose_func 6 (Function_7(relation));
 		Hashtbl.add general_purpose_func 7 (Function_11(relation_mapping));
 		Hashtbl.add general_purpose_func 8 (Function_8(getSomeInfo));
 		Hashtbl.add general_purpose_func 9 (Function_9(getLabel));
 		Hashtbl.add general_purpose_func 10 (Function_5(getTheNodeLabel));	

 		Hashtbl.add functions 5 general_purpose_func;
 		Hashtbl.add functions 1 functions_1;
 		Hashtbl.add functions 2 functions_2;
 		Hashtbl.add functions 3 functions_3;
 		Hashtbl.add functions 4 functions_4;

 		end	
 	let getRelation (rel:string) :relWithParent = 
 		match rel with 
			| "NoRelation" -> NoRelation | "Istaught"  -> Istaught | "Assistantof" -> Assistantof 
			| "WorkOnAproject" -> WorkOnAproject | "Teaches" -> Teaches | "IsTakenBy" -> IsTakenBy
    		| "Colleagues" -> Colleagues | "ClassMates" -> ClassMates | "WrittenBy" -> WrittenBy
    	    | "RecommendedBy" -> RecommendedBy | "IstaughtBy" -> IstaughtBy | "SameDept" -> SameDept
			| "UseTheBook" -> UseTheBook | "SameSubject" -> SameSubject | "UseBy" -> UseBy
		    | "WroteThe" -> WroteThe | "TakeTheCourse" -> TakeTheCourse | "UseForTheCourse" -> UseForTheCourse
		    | _ -> NoRelation
	let func_modification newfunc =
		begin 
		    print_string ("\t++------------------------------------------------++");
			print_string  ("\n\t+  THIS IS THE LIST OF FUNCTIONS                +");
			print_string  ("\n\t+  1) Insert                                    +");
			print_string  ("\n\t+  2) Insert_rel                                +");
			print_string  ("\n\t+  3) delete                                    +");
			print_string  ("\n\t+  4) delete_lecturer                           +");
			print_string  ("\n\t+  5) delete_student                            +"); 
			print_string  ("\n\t+  6) delete_book                               +"); 
			print_string  ("\n\t+  7) delete_course                             +"); 
			print_string  ("\n\t+  8) delete_all                                +");
			print_string  ("\n\t+  9) delete_cons                               +");
			print_string  ("\n\t+  10) edit                                     +");
			print_string  ("\n\t+  11) edit_a_lecturer                          +");
			print_string  ("\n\t+  12) edit_a_student                           +");
			print_string  ("\n\t+  13) edit_a_course                            +");
			print_string  ("\n\t+  14) edit_a_book                              +");
			print_string  ("\n\t+  Choose the functions you want to modify      +");
			print_string  ("\n\t++---------------------------------------------++") ;
			print_string ("\n\t+ ");
	
				 	let select = read_int () in
					match select with 
					| 1 ->  Hashtbl.replace (Hashtbl.find functions 5) 1 (newfunc)
					| 2 -> Hashtbl.replace (Hashtbl.find functions 5) 2 (newfunc)
					| 3 -> Hashtbl.replace (Hashtbl.find functions 5) 3 (newfunc)
					| 4 -> Hashtbl.replace (Hashtbl.find functions 1) 1 (newfunc)
					| 5 -> Hashtbl.replace (Hashtbl.find functions 2) 1 (newfunc)
					| 6 -> Hashtbl.replace (Hashtbl.find functions 4) 1 (newfunc)
					| 7 -> Hashtbl.replace (Hashtbl.find functions 3) 1 newfunc
					| 8 -> Hashtbl.replace (Hashtbl.find functions 5) 4 newfunc
					| 10 ->  Hashtbl.replace ( Hashtbl.find functions 5 ) 11 newfunc
					| 11 ->  Hashtbl.replace ( Hashtbl.find functions 1 ) 2 newfunc
					| 12 ->  Hashtbl.replace ( Hashtbl.find functions 2 ) 2 newfunc
					| 13 ->  Hashtbl.replace ( Hashtbl.find functions 3 ) 2 newfunc
					| 14 ->  Hashtbl.replace ( Hashtbl.find functions 4 ) 2 newfunc
					| _  -> Hashtbl.replace (Hashtbl.find functions 5) 5 newfunc
						  
		end

	let getOptionString () = 
		let element = read_line () in
		match element with 
			| "" | " " -> None 
		    | x -> Some x


 	let create () = 
 		begin 
 			print_string ("\t+--------------------+\n");
 			print_string ("\t+  NODE CREATION     +\n");
 			print_string ("\t+  1) lecturer       +\n");
 			print_string ("\t+  2) student        +\n");
 			print_string ("\t+  3) course         +\n");
 			print_string ("\t+  4) book           +\n");
 			print_string ("\t+--------------------+\n");
 			print_string ("\t+ ");
 			let select = read_int () in 
 			match select with 
 				| 1 -> 
 					print_string ( "\t++++---------------------------------------++++\n");
 					print_string ( "\t+++          Enter lecturer infos           +++\n");
 					print_string ( "\t++ (security_number, first name, last name ) ++\n");
 					print_string ( "\t++++---------------------------------------++++\n");
 					let sn = read_line () in 
 					let fn = read_line () in 
 					let ln = read_line () in 
 					Lecturer ({ security_number = sn; fname = fn; lname = ln; }) 
 				| 2 ->
 				    print_string ( "\t++++---------------------------------------++++\n");
 					print_string ( "\t+++         Enter student infos             +++\n");
 					print_string ( "\t++    (matricule, first name, last name )    ++\n");
 					print_string ( "\t++++---------------------------------------++++\n");
 					let mn = read_line () in 
 					let fn = read_line () in 
 					let ln = read_line () in 
 					Student ({ matricule = mn; first_name = fn; last_name = ln; }) 
 				| 3 ->
 					print_string ( "\t++++---------------------------------------++++\n");
 					print_string ( "\t+++           Enter course infos            +++\n");
 					print_string ( "\t++             ( title, code )               ++\n");
 					print_string ( "\t++++---------------------------------------++++\n");

 					let t = read_line () in 
 					let c = read_line () in 
 					Course ({ title = t; code = c; })
 				| _ ->
 					print_string ( "\t++++---------------------------------------++++\n");
 					print_string ( "\t+++           Enter book infos              +++\n");
 					print_string ( "\t++         ( title, author, num )            ++\n");
 					print_string ( "\t++++---------------------------------------++++\n");
 					                							   					
 					let t = read_line () in 
 					let c = read_line () in
 					let n = read_int () in  
 					Book ({ title = t; author = c; number_pages = n; })
 								  					
 		end

 	let rec run (root: diffType multree_) = 
 		begin 
 			print_string ("\t+--------------------------------+\n");
 			print_string ("\t+  CHOOSE WHAT YOU WANT TO DO    +\n");
 			print_string ("\t+  1) insert ( or create tree )  +\n");
 			print_string ("\t+  2) edit a node                +\n");
 			print_string ("\t+  3) delete a node              +\n");
 			print_string ("\t+  4) modify a function          +\n");
 			print_string ("\t+--------------------------------+\n");
 			print_string ("\t+ ");
 			let select = read_int ( ) in 
 			let process_1 select node = 
 				begin

     				match select, node with 
 						| 1, Leaf -> Node ( create(), {rel=NoRelation; logicParent = ("", ""); type_ = true;}, Leaf, Leaf )
 						| 1, r -> 
 						print_string ("\t++--------------------------------------------------------------------++\n");
 						print_string ("\t+            Enter the following information in order                  +\n");
 						print_string ("\t++--------------------------------------------------------------------++\n");
						print_string ("\t+ 1) The infos on the node that will be the parent                     +\n");
						print_string ("\t+                                                                      +\n");
						print_string ("\t+      ( infos for a lecturer or a student are the                     +\n");
						print_string ("\t+        first and last name fo a book the title and                   +\n");
						print_string ("\t+        for a course the title and the code )                         +\n");
						print_string ("\t+ 2) Enter the relation with the chosen parent                         +\n");
						print_string ("\t++--------------------------------------------------------------------++\n");
						print_string ("\t++                 These are the relations provided                   ++\n");
						print_string ("\t++--------------------------------------------------------------------++\n");
						print_string ("\t+ 2) Enter the relation with the chosen parent                         +\n");
				   	 	print_string ("\t+  NoRelation        Istaught          Assistantof                     +\n");   
						print_string ("\t+  WorkOnAproject    Teaches           IsTakenBy                       +\n");  
    			    	print_string ("\t+  Colleagues        ClassMates        WrittenBy                       +\n");  
    	            	print_string ("\t+  RecommendedBy     IstaughtBy        SameDept                        +\n");  
			        	print_string ("\t+  UseTheBook        SameSubject       UseBy                           +\n");  
		            	print_string ("\t+  WroteThe          TakeTheCourse     UseForTheCourse                 +\n"); 
						print_string ("\t++--------------------------------------------------------------------++\n");
 							let parInfo1 = read_line () in 
 							let parInfo2 = read_line ( ) in
 							let rel = getRelation ( read_line ()) in 
 							let Function_2(func) = (Hashtbl.find (Hashtbl.find functions 5) 2) in 
 							func (create()) (parInfo1, parInfo2) rel r
 						| _, x -> x
 						| _, Leaf -> Leaf 
 				end	
in
			let process_2  select node = 
				begin
					print_string ("\t++--------------------------------------------------------++\n");
					print_string ("\t+        Enter the following information in order          +\n");
					print_string ("\t++--------------------------------------------------------++\n");
					print_string ("\t+ 1) The infos on the node you want to modify              +\n");
					
					print_string ("\t+ ( infos for a lecturer or a student are the   +\n");
					print_string ("\t+  first and last name fo a book the title and  +\n");
					print_string ("\t+  for a course the title and the code )        +\n\n");
					print_string ("\t+ 2) Enter the element to modify in the order   +\n\t+ of the record ------------------------------++\n");
					print_string ("\t   ( you are not compelled to enter infos you  +\n\t+can go to the next line if you don 't desire to)\n");
										print_string ("\t++------------------------------------------------------------++\n");

					match select with 
					| 2 -> 
						let info1  = read_line () in 
						let info2 = read_line() in
						let element1 = getOptionString () in 
						let element2 = getOptionString () in 
						let element3 = getOptionString () in
						let Function_6(func) = (Hashtbl.find ( Hashtbl.find functions 5  ) 11)  in 
						func (info1, info2 ) (element1, element2, element3 ) node
					| _ -> node				
				end
			in 
			let process_3 select node =
				if select <> 3 then node 
				else 
					let info1 = read_line () in 
					let info2 = read_line () in 
					let Function_3 (func ) = (Hashtbl.find general_purpose_func 3) in 
					func (info1, info2) node 
			in 

			match select with 
			 | 1 ->   process_1 select root
			 | 2 -> process_2 select root
			 | 3 -> process_3 select root 
		     | _ ->
	      print_string("\t+ ++------------------------------------------------------------------------------------------------------------------------+++\n");
	      print_string("\t+                  Possible constructor for func_modification ( eg func_modification (constructor (newfunc)))                 +\n");
	       print_string("\t+ ++------------------------------------------------------------------------------------------------------------------------+++\n");
		 
		  print_string ("\t+ | Function_2 of ('a -> string*string -> relWithParent ->'a multree_  -> 'a multree_ )                                       +\n");
 		  print_string ("\t+ | Function_1 of ('a -> diffType multree_ -> relWithParent -> bool -> string * string -> diffType multree_)                  +\n");
 		  print_string ("\t+ | Function_3 of (string*string -> 'a multree_ -> 'a multree_ )                                                              +\n");
 		  print_string ("\t+ | Function_4 of ('a multree_ -> 'a multree_ -> 'a multree_)                                                                 +\n");
 	      print_string ("\t+ | Function_5 of (string*string -> 'a multree_ -> int)                                                                       +\n");
 		  print_string ("\t+ | Function_6 of ( string*string -> string option * string option * string option -> 'a  multree_ -> 'a multree_)            +\n");
 		  print_string ("\t+ | Function_7 of (diffType * diffType -> int )                                                                               +\n");
 		  print_string ("\t+ | Function_8 of (diffType -> string * string )                                                                              +\n");
 		  print_string ("\t+ | Function_9 of (diffType -> int)                                                                                           +\n");
 		  print_string ("\t+ | Function_10 of (diffType multree_ -> int )                                                                                +\n");
 	      print_string ("\t+ | Function_11 of (int -> relWithParent -> bool)                                                                             +\n");
 	      print_string ("\t+ | Function_12 of  (string * string -> string * string ->diffType multree_ -> diffType multree_ -> diffType multree_)        +\n");
		  print_string ("\t+ | Function_13 of ( string*string -> string option * string option  -> 'a  multree_ -> 'a multree_)                          +\n");
		   print_string("\t+ ++------------------------------------------------------------------------------------------------------------------------+++\n\n");
		   	root
 		end	
	end;;

