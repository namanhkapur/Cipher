(* ::Package:: *)

(* ::Title:: *)
(*ISP: Road to Cryptography*)


(* ::Chapter:: *)
(*By Namanh Kapur*)


(* ::Section:: *)
(*Decrypting for User-Specified Input*)


(* ::Input:: *)
(*Needs["Notation`"];*)


(* ::Input:: *)
(*(* Creating my own version of Ascii with 73 characters*)*)


(* ::Input:: *)
(*asciiVector = {" ","!","'","(",")",",","-",".",":",";","?","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9"}; *)


(* ::Input:: *)
(*sizeOfArray=73;*)
(*startingIndex=0;*)
(*u=Array[U[#1]&,sizeOfArray,startingIndex];*)


(* ::Input:: *)
(*(* Starts indexing from 0 instead of 1 *)*)


(* ::Input:: *)
(*Notation[ParsedBoxWrapper[SubscriptBox["asciiVector", "i_"]] \[DoubleLongLeftRightArrow] ParsedBoxWrapper[RowBox[{"asciiVector", "[", RowBox[{"[", RowBox[{"i_", "+", "1"}], "]"}], "]"}]]];*)


(* ::Input:: *)
(*(* Allowing user to specify size of key (in bound of length of message) filled with random values from 0-73. Makes sure that they key is invertible with the help of recursion. *)*)


(* ::Input:: *)
(*decryptKey[keySize_]:=Module[{temp =Table[RandomInteger[{0,73}],{i,keySize},{j,keySize}]}, If[Det[temp]!=0, temp, decryptKey[keySize]]]*)


(* ::Input:: *)
(*(* messageVector makes each index hold one letter (in order) of message *)*)


(* ::Input:: *)
(*messageVector[message_]:= Table[messageVector[[i]] =StringTake[message, {i,i}], {i,1,StringLength[message]}];*)


(* ::Input:: *)
(*(* Checks to ensure that decryption can proceed *)*)


(* ::Input:: *)
(*checkMessage[message_,keySize_]:= If[StringLength[message]>= keySize, Return["yes"] , Return["no"]];*)


(* ::Input:: *)
(*(* Return a matrix where columns are the first keySize chunks of message *)*)


(* ::Input:: *)
(*breakMessage[padVector_, keySize_] := Return[Transpose[Partition[padVector,keySize]]]*)


(* ::Input:: *)
(*(* Converts the letters to their number counterparts *)*)


(* ::Input:: *)
(*convertMessage[messageMatrix_] := ArrayFlatten[Table[Position[asciiVector,messageMatrix[[i,j]]]-1, {i,Length[messageMatrix]},{j,Length[messageMatrix[[1]]]}]]*)


(* ::Input:: *)
(*(* Decrypts each column vector into comprehendable language *)*)


(* ::Input:: *)
(*decryptKey[convertedMatrix_, keyMatrix_] :=Transpose[Module[{temp = Inverse[keyMatrix, Modulus-> 73]},Table[Mod[temp.convertedMatrix[[All,i]],73], {i,Length[convertedMatrix[[1]]]}]]]*)


(* ::Input:: *)
(*(* Converts the decryptedMatrix into letter representing each decrypted letter *)*)


(* ::Input:: *)
(*letterDecrypt[decryptedMatrix_] := Table[Subscript[asciiVector, decryptedMatrix[[i,j]]], {i,Length[decryptedMatrix]},{j,Length[decryptedMatrix[[1]]]}]*)


(* ::Input:: *)
(*(* Shows letterDecrypt in sentence form *)*)


(* ::Input:: *)
(*showSentenceDecrypted[letterDecrypt_] :=Module[{mat = Flatten[Transpose[letterDecrypt]], temp = ""},For[i=1,i<= Length[mat],i++, temp = StringJoin[temp,mat[[i]]]]; Return[temp]] *)


(* ::Input:: *)
(*(* Performs decryption in one step with one input and one output *)*)


(* ::Input:: *)
(*doDecryption[message_, keySize_, keyMatrix_]:= Module[{tempMsgVect = messageVector[message],tempTest,tempConvert,tempDecryptNumb,tempFinalDecrypt, tempShowSentence, },   *)
(*tempTest = breakMessage[tempMsgVect, keySize];*)
(*tempConvert = convertMessage[tempTest];*)
(*tempDecryptNumb = decryptKey[tempConvert, keyMatrix];*)
(*tempFinalDecrypt= letterDecrypt[tempDecryptNumb];*)
(*tempShowSentence = showSentenceDecrypted[tempFinalDecrypt];*)
(*ToString[tempShowSentence]]*)


(* ::Section:: *)
(*User-Friendly Decryption*)


(* ::Input:: *)
(*newMessage =  InputString["What was your encrypted message?"];*)


(* ::Input:: *)
(*newKeySize =Input["Please enter the key size of the key matrix you used to decrypt your message (it should be the same key size as the one you used when decrypting)."];*)


(* ::Input:: *)
(*newKeyMatrix = Table[Input[Row[{"Please enter components of the key matrix in order: ",i," ",j}]],{i,newKeySize},{j,newKeySize}];*)


(* ::Input:: *)
(*Module[{temp =doDecryption[newMessage, newKeySize,newKeyMatrix]},For[i=1,i<=3,i++,*)
(*If[i==1, Print[Style["Your encrypted message was: ",Red, Italic,14],Style[newMessage,Bold,14]], If[i==2, Print[Style["Your key was: ", Red, Italic,14]]; Print[Style[newKeyMatrix//MatrixForm, Bold,14]], If[i==3, Print[Style["Your decrypted text is: ", Red, Italic,14]];  Print[Style[temp,Bold, 14]]]]]]]//Quiet*)


(* ::Section:: *)
(*For Debugging*)


(* ::Input:: *)
(*uno = messageVector[newMessage]//Quiet*)


(* ::Input:: *)
(*tres = breakMessage[uno,newKeySize]; tres//MatrixForm*)


(* ::Input:: *)
(*cuatro = convertMessage[tres];cuatro//MatrixForm*)


(* ::Input:: *)
(*cinco = decryptKey[cuatro, newKeyMatrix]; cinco//MatrixForm*)


(* ::Input:: *)
(*Inverse[newKeyMatrix, Modulus->73]*)


(* ::Input:: *)
(*seis = letterDecrypt[cinco]; seis//MatrixForm*)


(* ::Input:: *)
(*siete = showSentenceDecrypted[seis]*)
