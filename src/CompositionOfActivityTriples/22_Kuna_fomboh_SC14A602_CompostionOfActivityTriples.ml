
(*												COMPOSITION OF ACTIVITY TRIPLES

Software Package: Project


PURPOSE OF THIS SOFTWARE:
	This program provides a ternary tree which effectively proovides a search space for triples of activities to be investigated. 


AUTHORS
	
	NAME						MATRICULE #

	Kuna Ngwanchang Fomboh      SC14A602
	Tchassem Guemte Borel       SC14B182
	Mukah Mukah Ispahani        SC14B369
	Esibe Roy Ngu               SC14B396

MODIFICATION HISTORY

Version 3.0
- 04\05\16: We modified the ternary tree such that it held a node instead of a tuple of singlex structures as before.
-18\05\16: We modified the singlex structure such that it was composed only of the xj component and the result after the function application
-18\05\16: We modified the node structure such that it no longer had the composition function. This was because we did not do composition of the result.
-24\05\16: We modified the insert function such that took only one parameter which is the value to be inserted. This was because we kept having syntax errors.
-26\05\16: The program initially requested that the user enter a choice for the function application. This was modified such that the the program randomly generates a choice for the function to be applied. 
-26\05\16: Modified the dashboard such that it gave information on the computation that had taken place.

 PROGRAM LOGIC 
  We define node of a ternary tree wherein we allow for on-demand generation ("structure generation") of tree nodes and application of the "function application" to concrete (specific) arguments ("instantiation").

  Each node holds the following sets of information:
  - "Structure Generation": Value of the node is the tuple X == (x1, x2, ... xj, ... xNX). This is held in an array with NX tuple entries. (For efficiency [in C], each tuple entry has data type "Singlex", and holds the data of a given xj and the results of "function application" to it (the xj).) Each xj can expect up to NF nodes generated for NF "function components" applied to it. Each xj thus has links (pointers) to, and so can generate, NF child nodes.

   "Singlex" is the structure that holds information of/for each X-component (xj), viz., its: "function application", F(xj), instantiation argument (a), composition function (g), and compostion result g(F(xj)).

  - "Function Application": The function (stre) to be applied is actually a vector (sequence) of functions. Call the function F == (f1, f2, ... fi ... fNF). It is a map to be applied to node value X. Strictly, F is to be applied to each component of xj of X. That is, the tuple F(X) == (F(x1), F(x2), ... F(xj) ... F(xNX)) where F is applied to each component, xj of X. Technically, X could be another function or the result of other function applications.

  Now, each F(xj) == (f1(xj), f2(xj), ... fi(xj) ... fNF(xj)) is a tuple of NF X-components. So, each F(xj) generates NF X-components. (Their pointers are stored in the structure for each xj, making a total of NX*NF components, if all are generated. We require F (or its components) be applied at most once on each xj (on behalf of node X, barring recursive calls) and [F] then conceptually deleted for it (the xj), lest F be applied to xj again. F thus captures function (or map) application, which can be deferred indefinitely. In this wise, we can defer the generation of nodes (X-components) until necessary. (Note, from above, that the generated nodes hold the results of function application.)

  - "Instantiation": The possible "function applications" generated above need to be applied to specific, concrete components, to obtain concrete (specific) results. Thus, we need a [concrete] argument, a "composition function" to compose (combine) the results from the F(xj)'s to give a final result. Each xj may return its own "concrete" result, which can similarly be aggregated (composed) to obtain the final concrete result for node X.

The "composition function" is essentially an auxilliary operation, g, which generally combines results into fewer nodes, and should normally NOT generate further results nodes. Suppose we have F(x) == (f1, f2, f3) x == (f1(x), f2(x), f3(x)) == (ax^2, bx, c). Then, g == addition (+) is the "composition function" in F(x) == f(x) = ax^2 + bx + c, as it is used to "combine" the results of f1, f2, and f3.

Conceptually, "function application" may apply function F to object X where X may contain variables (e.g., variable x in f(x) = ax^2 + bx + c) and unknown constants, such as a, b or c. "Instantiation" allows the replacement of such variables and constants with concrete (known) values.

Finally, "Instantiation" could be partial in the sense that not all needed concrete values are provided. Also, definition of "compostion functions" (and other operations in F) may be deferred. In which case a functional is returned.


OPEERATIONS:
  - "apply" and composition operations, as described above.
  - some apply operations include:
	
	applyMap(F, X, g) == (g(f1(x1)), g(f2(x2)), g(f3(x3)))
	apply F as if a scalar on X:
	applyScalar(F, X) == (f1(x1), f2(x2), f3(x3))
	
*)

(*"Singlex" is the structure that holds information of/for each X-component (xj), viz., its: "function application", F(xj), instantiation argument (a), composition function (g), and compostion result g(F(xj)).*)

(*exception Error of string ;;  to be used for any error encountered *)


(* singlex is simply defined as such because of language contraints that would rise if done otherwise*)
type 'a a_singlex = {
	mutable func_x : 'a ; (*xj component*)
	mutable func_result : 'a(*f(x1), f(x2)...f(xn): consrete result after function composition forthis specific singlex*)
	};;
 
(* defining singlex compoments to be held by node *)
 let s1 = { func_x =1 ; func_result= 0 } ;;
 let s2 = { func_x =2  ; func_result= 0 } ;;
 let s3 = { func_x =3  ; func_result= 0 } ;;

(* putting the singlex components in a tuple*)
let singlex_tup = (s1,s2,s3);;

(* ternary tree node stucture definition*)
type 'a the_node = {
	nx : int; (*no of child nodes*)
	nf : int; (*no of function components: 3 in this case*)
	mutable nod_tup : 'a  a_singlex * 'a a_singlex *'a a_singlex ; 
	mutable fxn_result : 'a*'a*'a (*combined concrete result after function composition*)

	};; 

(* creation and initialising the  parent node which we called " nodeob" and which is of type "the_node" ,its just like an object*)     
let nodeOb = { nx = 3 ; nf = 3 ;  nod_tup = singlex_tup  ;  fxn_result =(0,0,0) } ;;


(* ternary tree definition and creation*)
type  'a t_tree = Empty | Node of 'a the_node * 'a t_tree * 'a t_tree * 'a t_tree;;

(*function insert inserts a value to a node*)
let rec insert (x: 'a the_node)  = function  

   Empty->Node(x,Empty,Empty,Empty)
   |Node(v, Empty, Empty, Empty )->Node(v,insert x Empty,Empty,Empty)
   |Node(v, s,Empty, Empty )->Node(v, s, insert x Empty,Empty)
   |Node(v, s, t, Empty )-> Node(v, s, t, insert x Empty)
   |Node(v,s,t, u)-> Node(v, s, t, u) ;;

(* individual fxn f1,f2,f3 to be applied, we considered predefining for now*)
let f1 a = 2*a;;
let f2 b = 3*b;;
let f3 c = 4*c;;
let g  n = n+1 ;;

(* different applyfunctions which take as parameters the values stored in the individual singlexes*)
let applyMatch ( f1,f2 ,f3 ) (p, q ,r)  = ( f1 p.func_x    , f2 q.func_x   ,  f3 r.func_x   ) ;;

let applyMap  (f1,f2,f3) (p, q ,r) g = (   g (  f1 p.func_x ) , g ( f2 q.func_x ), g ( f3 r.func_x ) );;

let applyFold (f1,f2,f3) (p, q ,r) g = (  g (f1 p.func_x)  , g (f2 q.func_x) , g ( f3 r.func_x )   );;

let applyScalar (f1,f2,f3) (p, q ,r) = (  f1 (p.func_x ) ,  f2 ( q.func_x ),  f3 ( r.func_x ) );;
  
(*  we create a tuple variable of type ""the_singlex to reference the parent singlexes s1,s2,s3*)
let (x1,x2,x3)= nodeOb.nod_tup ;;


(*initialization of variable store*)
type store = { mutable value : int*int*int};;

let storage = { value = (0,0,0) } ;;  (* a tuple variable to store the results of fxn operation before insertion in children node*)
  
let (i,j,k) = storage.value ;;(* to store the values in the tuple storage *)

let retFxnResult (i,j,k)=(i,j,k) ;;(* return_fxn_results : returns to us the values return by each appy function so we can store  or use them *)

         
(* a fxn to choose what function to apply and from the choice this fxn will return results from the fxn processing *) 
let dashBoardChoice n = 
    	match n with 
    		  1 -> retFxnResult ( applyMatch (f1,f2,f3) (x1,x2,x3) )
    		| 2 -> retFxnResult ( applyMap (f1,f2,f3) (x1,x2,x3) g )
    		| 3 -> retFxnResult ( applyFold (f1,f2,f3) (x1,x2,x3) g )
    		| 4 -> retFxnResult ( applyScalar (f1,f2,f3) (x1,x2,x3) )
    		| _ -> retFxnResult (0,0,0)  ;;


(*functions take a tuple returned from the function application and returns a node as a result for easy insertion into the tree*)
let doLeftChild n =
               { nx = 3; nf = 3; nod_tup = (   { func_x = n ; func_result= 0 },
               { func_x =0  ; func_result= 0 } , { func_x =0  ; func_result= 0 } ) ; fxn_result = (0,0,0) } ;;

let doRightChild n =
               { nx = 3; nf = 3; nod_tup = (   { func_x = n ; func_result= 0 },
               { func_x =0  ; func_result= 0 } , { func_x = n  ; func_result= 0 } ) ; fxn_result = (0,0,0) } ;;

let doMidChild n =
               { nx = 3; nf = 3; nod_tup = (   { func_x = n ; func_result= 0 },
               { func_x = n  ; func_result= 0 } , { func_x =0  ; func_result= 0 } ) ; fxn_result = (0,0,0) } ;;

let ternaryTree = Empty  ;; (* instantiation and intialising of ternaryTree which is of type t_tree above *)
let ternaryTree = insert nodeOb ternaryTree ;;  (* inserting the predefined parent node named nodeOb above *)

   
    print_string " Activity of triples simulation program" ;;
    print_string "\n Authors : 
    \n Kuna Ngwanchang Fomboh      SC14A602
	\n Tchassem Guemte Borel       SC14B182
	\n Mukah Mukah Ispahani        SC14B369
	\n Esibe Roy Ngu               SC14B396     " ;;
  
    print_string "\n release version : 2.0 " ;;
  
    print_string "\n We provide a ternary tree as search space for any triple of activities \n";;
    print_string "\n the parrent node was initialised for you choose the function to apply \n";;
   
    print_endline " enter 1 to applymatch \n" ;;
    print_endline " enter 2 to applymap \n"  ;;
    print_string  " enter 3 to applyfold \n" ;;
    print_string  " enter 4 to applyscalar \n" ;;

  
let choice = 1 + Random.int 3;;

let (a,b,c) = dashBoardChoice choice ;;

(*this tuple variables a,b,c store the fxn operation result that is used to initialise  each child-node    singlex before insertion in the tree *) 
(*node insertion into a tree *)
    
 let ternaryTree =   insert ( doLeftChild a )  (ternaryTree );; (*insertion of the left child *)
 let ternaryTree =   insert ( doMidChild b ) (ternaryTree) ;; (*insertion of the middle child*)
 let ternaryTree =   insert ( doRightChild c ) (ternaryTree );;(*insertion of the right child*)
    

(* To test all program functions and insertion we used this sample code in ocaml : 
	let (a,b,c) = retFxnResult ( applyMatch ( f1,f2 ,f3 ) (x1, x2 ,x3) );;
  *) 
 
 ternaryTree ;;

 print_string  " parent node and first level ternary tree was generated with success \n" ;;
 (*The dashboard holds information about the operations that were performed, the number of tree levels generated, composition order and whether functions were applied or stored*)

   
	print_string "DASHBOARD";  
    print_string "
    \n The following operations were performed
	\n\t choice from the list of function applications
	\n\t We generated new child nodes to get one tree level
	\n\t The tree gives a result of a tree with a parent node and three child nodes";
	print_string "\n One Tree level was generated
	\n Functions were not stored but applied directly
	\n No query operations were performed " ;;


(* To test all program functions and insertion we used this sample code in ocaml : 
	let (a,b,c) = retFxnResult ( applyMatch ( f1,f2 ,f3 ) (x1, x2 ,x3) );;
  *) 


	

