(*
Program: Persistent interval tree                
Purpose: Store data in a persitent interval tree  
Group: 1.2ab       
Group members: Amate Yolande SC13A053
               Djimeli Konrad SC14A305          
*)
open Printf

(*Tree interval record*)
type intval = 
	{high: int;
	 low : int;};;

(*Tree data node record*)
type node =
	{mutable max: int;
	 data: int;
	 interval: intval;
	};;

(*Tree record*)
type 'a tree =
    Node of 'a * 'a tree ref * 'a tree ref
  | Leaf;;
  
(*Double linked list record*)
type 'a dlist =
	  Nil
	| Listnode of 'a * 'a dlist ref * 'a dlist ref

(*Dummy node for null value*)
let null = (Listnode(ref Leaf, ref Nil, ref Nil));;

(*Doubly linked list insert function*)
let rec list_insert ls elem =
	match elem, !ls with
	  Listnode (_, prev, next), Nil -> elem;
	| Listnode (_, _, _), (Listnode (_, _, next)) ->
	    let tmp = ref Nil in    
	    tmp := list_insert next elem; 
	    let set_prev prev cur =
	        match prev , cur with
	         Listnode (_, _, _), Listnode (_, prev1, _) -> prev1 := prev
	       | _, _ -> ();
	    in set_prev !ls !tmp;
	    next := !tmp;    
	    !ls
	| Nil, _ ->
		raise (Invalid_argument "insert")

(*Calculate the max for three values*)
let max a b c = 
	if a > b then 
		if a > c then
			a
		else
			c
	else if b > c then
		b
	else
		c;;
(*Get tree node value*)
let get_node_val x =
    match x with
     Node (n, _, _) -> n
   | Leaf -> {data=0; max=0; interval={high=0 ; low=0}};;

(*Calculate the max for three nodes*)
let nodeMax a b c =
    match a, b, c with 
     Node (x, _, _), Node (y, _, _), Node (z, _, _) -> max x.interval.high y.max z.max
   | Node (x, _, _), Node (y, _, _), Leaf -> max x.interval.high y.max y.max 
   | _, _, _ -> -1;;
		
		
(*Calculate the max for the interval of node on the tree*)
let intervalMax n =
    match n with
     Leaf -> ()
   | Node (y, left, right) ->
		if !left != Leaf && !right != Leaf then
		    y.max <- nodeMax n !left !right
		else if !left != Leaf then
		    y.max <- nodeMax n !left Leaf
		else if !right != Leaf then
		    y.max <- nodeMax n !right Leaf
		else
		    y.max <- y.interval.high;;
  	
(*Function to insert a node into a tree with persistence*)
let rec persist_insert x n =
	match n with
	Leaf -> Node (x, ref Leaf, ref Leaf) (*Return new node to be added*)
  | Node (y, left, right) ->
  if x.interval.low < y.interval.low then (
        if (x.interval.high >= y.interval.low) || (!right != Leaf && ( (get_node_val !right).interval.low <= x.interval.high )) then (
            print_newline();
            print_string "/** Interval overlap **/";
            print_newline();  n
        )else(
		let tmp = ref Leaf in 
		tmp := persist_insert x !left; (*Create a reference to child node*)
		intervalMax !tmp;
		if !tmp = n then 
			n (*If node has not changed return the same node*)
		else (
		    let n = {data=y.data; max=y.max; interval={high=y.interval.high ; low=y.interval.low}} in
			Node (n, tmp, right)))) (*Else return a copy of current node and attach child node to it*)
  else if x.interval.low > y.interval.low then (
        if (x.interval.low <= y.interval.high) || (!left != Leaf && ( (get_node_val !left).interval.high >= x.interval.low )) then (
            print_newline();
            print_string "/** Interval overlap **/";
            print_newline();  n
        )else(
		let tmp = ref Leaf in 
		tmp := persist_insert x !right; (*Create a reference to child node*)
		intervalMax !tmp;
		if !tmp = n then
			n  (*If node has not changed return the same node*)
		else(
		    let n = {data=y.data; max=y.max; interval={high=y.interval.high ; low=y.interval.low}} in
	 		Node (n, left, tmp)))) (*Else return a copy of current node and attach child node to it*)
  else(
       print_newline();
	   print_string "/** Node already exists **/";
	   print_newline(); n);; (*If node has not changed return the same node*)

(*Swap left and right value to successor node after the deletion of node*)
let swap n1 n2 r = 
    match n1 , n2 with 
    Node (x1, left1, right1), Node (x2, left2, right2) -> Node (x2, left1, ref r)
    | _, _-> Leaf;;


(*Print the values of an invterval*)
let print_interval = function
	  Leaf -> print_string ""
	| Node (y , _, _) ->
	  Printf.printf "Data {%d}, Interval [%d , %d], Max {%d}" y.data y.interval.low y.interval.high y.max;
	  print_newline();;

(*Return least tree node*)  
let rec tree_min n =
    let tmp = ref Leaf in 
    let nd = ref Leaf in 
    tmp := !n;
    while !tmp != Leaf do
        match !tmp with
          Leaf -> ()
        | Node(_ , left, _) -> nd := !n; tmp := !left;
    done;
    !nd;;


(*Delete node from the tree*)
let rec persist_delete h l n =
    match !n with
     Leaf -> print_newline();
             print_string "/** Node not found **/";
             print_newline(); !n
   | Node (x, left, right) ->
   
   if x.interval.low = l && x.interval.high = h then ( (*If the node has left and right children replace it with its successor*)
        if !left <> Leaf && !right <> Leaf then (
            let rec succ = fun nd -> (*Find node successor (least node from right child) *)
                match !nd with
                Leaf -> Leaf
              | Node (x, left, right) ->
                let tmp = ref (succ left) in 
                if !left == Leaf then
                    Leaf
                else(
                    intervalMax !tmp;
                    let n = {data=x.data; max=x.max; interval={high=x.interval.high ; low=x.interval.low}} in
                    Node (n, tmp, right)) 
                in swap !n (tree_min right) (succ right); (*Return copy of node in successor path*)
            
        ) else if !left <> Leaf && !right = Leaf then ( (*If the node has only a left child return the child, to replace the node*)
            !left;
        ) else if !left = Leaf && !right <> Leaf then (  (*If the node has only a right child return the child, to replace the node*)
            !right;
        ) else ( (*If the node has no child return Leaf, to replace the node*)
            Leaf
        )
   
   )else if x.interval.low > l then (
		let tmp = ref (persist_delete h l left) in  (*Create a reference to child node*)
		if !tmp = !n then
		    !n  (*If node has not changed return the same node*)
		else (
		    intervalMax !tmp;
		    let n = {data=x.data; max=x.max; interval={high=x.interval.high ; low=x.interval.low}} in 
	 		Node (n, tmp, right))) (*Else return a copy of current node and attach child node to it*)
   else if x.interval.low < l then (
		let tmp =  ref (persist_delete h l right) in (*Create a reference to child node*)
		if !tmp = !n then
			!n  (*If node has not changed return the same node*)
		else (
		    intervalMax !tmp;
		    let n = {data=x.data; max=x.max; interval={high=x.interval.high ; low=x.interval.low}} in (*Create a copy of data node*)
	 		Node (n, left, tmp))) (*Else return a copy of current node and attach child node to it*)
   else( 
        print_newline();
        print_string "/** Node not found **/";
        print_newline(); !n )
	;; (*If node has not changed return the same node*)
    

	  
  
(*Print all the node in the tree*)		
let rec print_tree n =
	match n with
    Leaf -> (); 
  | Node (y, left, right) ->
  	print_tree !left;
  	print_interval n;    
    print_tree !right
  ;;

(*Print values stored in doubly linked list*)
let rec print_list l v =
	match !l with
	 Nil -> ()
   | Listnode ( n, prev, next) ->
     print_newline();
     print_string "Tree version : ";
     print_int v;
     print_newline(); 
     print_tree !n;
     print_list next (v+1);;

(*Get the last item in the list*)  
let rec last_list_elem l =
    let tmp = ref Nil in 
    let nd = ref Leaf in
    
    tmp := !l;
    while !tmp != Nil do
        match !tmp with
          Nil -> ()
        | Listnode(n, _, next) -> nd := !n; tmp := !next;
    done;
    !nd;;

(*Collect data and insert into the list*)
let tree_insert = fun ls ->
	print_string "Enter node data value : ";
	let d = read_int() in
	print_string "Enter interval lower bound : ";
	let lw = read_int() in 
	print_string "Enter interval upper bound : ";
	let h = read_int() in 
	
	let n = {data=d; max=h; interval={high=h ; low=lw}} in 
	
	if !ls == null then (
	    let nval1 = persist_insert n Leaf in 
	    intervalMax nval1;
		ls := Listnode(ref nval1, ref Nil, ref Nil))
	else (
	    let nval2 = persist_insert n  (last_list_elem ls) in 
	    intervalMax nval2;
		ls := list_insert ls (Listnode(ref nval2, ref Nil, ref Nil)));;


(*Collect data and delete from the list*)
let tree_delete = fun ls ->
	print_string "Enter interval lower bound : ";
	let lw = read_int() in 
	print_string "Enter interval upper bound : ";
	let h = read_int() in 
	
	if !ls == null then ()
	else (
	    let nval = persist_delete h lw (ref (last_list_elem ls)) in
	     intervalMax nval;
		ls := list_insert ls (Listnode(ref nval, ref Nil, ref Nil)));;

(*Print usage*)
let usage = fun () ->
	print_newline();
	print_string "Enter the following commands";
	print_newline();
	print_string "1.) I or i -> insert node";
	print_newline();
	print_string "2.) P or p -> print list of tree versions";
	print_newline();
    print_string "3.) D or d -> to delete node from tree";
	print_newline();
	print_string "4.) Q or q -> quit";
	print_newline();;

(*Program main function*)
let mainfunc = fun () ->
	let l = ref null in 
	print_newline();
	print_string "PERSITENT INTERVAL TREE";
	print_newline();
    print_string "For every new node, a new version of the tree is created";
    print_newline();
    print_string "========================================================";
    print_newline();
	
	usage();
    print_string "Enter input : ";
	let input = ref (String.lowercase (read_line())) in
	
	while !input <> "q" do
	    if !input = "i" then
		    tree_insert l
		else if !input = "d" then
		    tree_delete l
	    else if !input = "p" then (
	        print_newline();
	        print_string "/** List contains the following tree versions **/";
	        print_newline();
		    print_list l 1;
	    );
	    usage();
        print_string "Enter input : ";
	    input := String.lowercase (read_line());
	done
   
;;

mainfunc();;
