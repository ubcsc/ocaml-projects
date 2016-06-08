(*File name: Generic_Modal_Logic.ml*)

(*Project title: Generic Modal Logic Resolver*)

(*Project number: 2.3*)

(*
Sotfware Purpose: 
-----------------
Code assorted modal operators and their axioms. Modal logics identify and define the basic
concepts and types of formal reasoning needed, and hence the kind of results expected.

To demonstrate the various forms of modal logic and their 
operators as well as their axioms. 
*)

(*Authors details:
  ----------------
 MOLINGE LYONGA JR SC14A750
 NGENGE SENIOR NLINWE SC14B373
 TANUE EUGEN-BLECK MBUNWO SC14B167
 TIFUH JEZEH PRIESTEN SC14B380
 Boubakary Wadjiri M 	SC14A229
*)

(*
         Modifications
		 -------------
- We used eta-expansion for the modal logic operators(diamond and box) and also for 
  temporal logic operators(sometimes and always) instead of a normal function definition.This
  is done by Molinge Lyonga Jr, inorder to keep things functional rather than imperative.
- We modified sometimes operator so that it make use of the key modal operator(diamond).
	This is done inorder to demonstrates the effective use of the condition "possibly"
  within the sometimes operation.

*)

(*Demonstrating what user can use or do*)
print_string "The modal logic operators are.\n";;
print_string "1. diamond\n2.Box\n";;
print_string "The possible properties to be tested are:\n";;
print_string "1.is_even\n2.is_odd\n3.is_multiple\n";;
print_string "The relations provided are\n";;
print_string "1.reflexive\n2.symmetric\n3.transitive\n4.euclidean\n";;
print_string "Frames provided are\n";;
print_string "1.t\n2.s4\ns5\n";;

(*In our code for(in) the functions; p stand for a property,
w, u, and v for possible worlds*)

(*Initial worlds which can be changed to have objects of any type*)
let w1 = [1; 4; 5; 7];;
let w2 = [2; 4; 6; 8];;
let w3 = [1; 3; 5; 7];;
let w4 = [9; 4; 2];;

(*The Function(for_some) ensures that condition p should be true at sometime(or world or object)*)
let rec for_some p w =
	match w with
	  [] -> false
	| y::w -> p(y) || for_some p w
;;

(*The function(for_all) ensures Condition p must always be true at all times (or world or object)*)
let rec for_all p w =
	match w with
	  [] -> false
	| y::w -> (p(y) && for_all p w)
;;

(*Property( or assertions) to be tested for integer objects*)

(*Property 1: Test if the value in question is an even number*)
let is_even (x:int):bool =  
	match x mod 2 with
	  0 -> true
	| _ -> false
;;

(*Property 2: Test is the value in question is an odd number*)
let is_odd (x:int):bool =
	match x mod 2 with
	  0 -> false
	| _ -> true	
;;

(*Property 3: Test if the second value in question is a multiple of the first value.*)
let is_multiple (x:int) (y:int):bool =
	match y mod x with
	  0 -> true
	| _ -> false
;;

(*Function exist test if a certain value exist in a world*)
let rec exist x w = 
	match w with
	  [] -> false
	| y::w -> x = y || exist x w
;;


(*modal logic operators using eta-expansion*)
(*1. diamond p: possibility*)
let diamond = (fun p w -> for_some p w);;

(*2. box P: necessity*)
let box = (fun p w -> for_all p w);;

(*Temporal Logic operators using eta-expansion*)
(*Function sometimes, test if property exist in a world at some time(or instance)*)
let sometimes = (fun p w -> for_some p w);;

(*Function always, test if *)
let always = (fun p w -> for_all p w);;

(*Accessibility relations or frame conditions based on an operator (either diamond or box)*)

(*Test if world w relates world w*)
let reflexive operator p w = 
	if (operator p w) = (operator p w) then
		true
	else
		false

(*Test if world w relates world u, which implies world u relates world w*)
let symmetric operator p w u =
	if  (operator p w) = (operator p u)  && 
		(operator p u) = (operator p w)  then
		true
	else
		false
;;

(*Test if w R u and u R q together imply w R q, for all w, u, q in G.*)
let transitive operator p w u v =
	if  (operator p w) = (operator p u) &&
		(operator p u) = (operator p v) &&
		(operator p w) = (operator p v) then 
		true
	else 
		false
;;

(*Test if for every u, t, and w, w R u and w R t implies u R t (note that it also implies: t R u*)
let euclidean operator p w u v =
	if (transitive operator p w u v) && (symmetric operator p u v) then
		true
	else
		false
;;


(*Logics that stem from the above Frame conditions using either diamond or box operator.*)
(*The t function checks if the provided world has a reflexive relation*)
let t operator p w = 
	if (reflexive operator p w) = true then 
		true
    else 
		false
;;

(*The s4 function is a combination of both reflexivity and transitivity relations*)
let s4 operator p w u v =
	if (reflexive operator p w) && (transitive operator p w u v) then
		true
	else 
		false
;;

(*The s5 function is a combination of both reflexivity and euclidean relations*)
let s5 operator p w u v = 
	if (reflexive operator p w) && (euclidean operator p w u v) then
		true
	else 
		false
;;