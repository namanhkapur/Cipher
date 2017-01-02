(* ::Package:: *)

(* ::Title:: *)
(*ISP: Road to Cryptography*)


(* ::Chapter:: *)
(*By Namanh Kapur*)


(* ::Section:: *)
(*Encrypting for User-Specified Input*)


(* ::Input:: *)
(*Needs["Notation`"];*)


(* ::Input:: *)
(*(* Creating my own version of Ascii with 73 characters*)*)


(* ::Input:: *)
(*asciiVector = {" ","!","'","(",")",",","-",".",":",";","?","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z", "0","1","2","3","4","5","6","7","8","9" }; *)


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
(*encryptKey[keySize_]:=Module[{temp =Table[RandomInteger[{0,73}],{i,keySize},{j,keySize}]}, If[Det[temp]!=0, temp, encryptKey[keySize]]]*)


(* ::Input:: *)
(*(* messageVector makes each index hold one letter (in order) of message *)*)


(* ::Input:: *)
(*messageVector[message_]:= Table[messageVector[[i]] =StringTake[message, {i,i}], {i,1,StringLength[message]}];*)


(* ::Input:: *)
(*(* Checks to ensure that encryption can proceed *)*)


(* ::Input:: *)
(*checkMessage[message_,keySize_]:= If[StringLength[message]>= keySize, Return["yes"] , Return["no"]];*)


(* ::Input:: *)
(*(* Pads end of message with spaces if need be *)*)


(* ::Input:: *)
(*padVector[messageVector_, keySize_] := Module[{temp=messageVector},If[Mod[Length[temp],keySize]==0,temp,While[Mod[Length[temp],keySize]!=0, temp =AppendTo[temp," "]]; Return[temp]]]*)


(* ::Input:: *)
(*(* Return a matrix where columns are the first keySize chunks of message *)*)


(* ::Input:: *)
(*breakMessage[padVector_, keySize_] := Return[Transpose[Partition[padVector,keySize]]]*)


(* ::Input:: *)
(*(* Converts the letters to their number counterparts *)*)


(* ::Input:: *)
(*convertMessage[messageMatrix_] := ArrayFlatten[Table[Position[asciiVector,messageMatrix[[i,j]]]-1, {i,Length[messageMatrix]},{j,Length[messageMatrix[[1]]]}]]*)


(* ::Input:: *)
(*(* Encrypts each column vector into mumbo-jumbo gibberish *)*)


(* ::Input:: *)
(*encryptKey[convertedMatrix_, keyMatrix_] := Transpose[Table[Mod[keyMatrix.convertedMatrix[[All,i]],73], {i,Length[convertedMatrix[[1]]]}]]*)


(* ::Input:: *)
(*(* Converts the encryptedMatrix into letter representing each encrypted letter *)*)


(* ::Input:: *)
(*letterEncrypt[encryptedMatrix_] := Table[Subscript[asciiVector, encryptedMatrix[[i,j]]], {i,Length[encryptedMatrix]},{j,Length[encryptedMatrix[[1]]]}]*)


(* ::Input:: *)
(*(* Shows letterEncrypt in sentence form *)*)


(* ::Input:: *)
(*showSentenceEncrypted[letterEncrypt_] :=Module[{mat = Flatten[Transpose[letterEncrypt]], temp = ""},For[i=1,i<= Length[mat],i++, temp = StringJoin[temp,mat[[i]]]]; Return[temp]] *)


(* ::Input:: *)
(*(* Performs encryption in one step with one input and one output *)*)


(* ::Input:: *)
(*doEncryption[message_, keySize_, keyMatrix_]:= Module[{tempMsgVect = messageVector[message],tempPaddedMsgVect,tempTest,tempConvert,tempEncryptNumb,tempFinalEncrypt, tempShowSentence, },   tempPaddedMsgVect = padVector[tempMsgVect,keySize];*)
(*tempTest = breakMessage[tempPaddedMsgVect, keySize];*)
(*tempConvert = convertMessage[tempTest];*)
(*tempEncryptNumb = encryptKey[tempConvert, keyMatrix];*)
(*tempFinalEncrypt = letterEncrypt[tempEncryptNumb];*)
(*tempShowSentence = showSentenceEncrypted[tempFinalEncrypt];*)
(*ToString[tempShowSentence]]*)


(* ::Section:: *)
(*User-Friendly Encryption*)


(* ::Input:: *)
(*message = InputString["Please enter the message you would like to encrypt:"];*)


(* ::Input:: *)
(*keySize =Input["Please enter your desired key size. The algorithm will encrypt in chunks of the key size you define. Please ensure that the key size that you enter is less than or equal to the number of characters in your message."];*)


(* ::Input:: *)
(*keyMatrix = Module[{temp},Input["A random key matrix of dimensions (keySize x keySize) will be created. Please enter your key size once again."]; temp = encryptKey[keySize]; temp];*)


(* ::Input:: *)
(*Module[{temp =doEncryption[message, keySize,keyMatrix]},For[i=1,i<=3,i++,*)
(*If[i==1, Print[Style["Your message was: ",Red, Italic,14],Style[message,Bold,14]], If[i==2, Print[Style["Your key was: ", Red, Italic,14]]; Print[Style[keyMatrix//MatrixForm, Bold,14]], If[i==3, Print[Style["Your encrypted text is: ", Red, Italic,14]];  Print[Style[temp,Bold, 14]]]]]]]//Quiet*)


(* ::Section:: *)
(*For Debugging*)


(* ::Input:: *)
(*uno = messageVector[message]//Quiet*)


(* ::Input:: *)
(*dos = padVector[uno,keySize]*)


(* ::Input:: *)
(*Length[dos]*)


(* ::Input:: *)
(*tres = breakMessage[dos,keySize]; tres//MatrixForm*)


(* ::Input:: *)
(*cuatro = convertMessage[tres];cuatro//MatrixForm*)


(* ::Input:: *)
(*cinco = encryptKey[cuatro, keyMatrix]; cinco//MatrixForm*)


(* ::Input:: *)
(*seis = letterEncrypt[cinco]; seis//MatrixForm*)


(* ::Input:: *)
(*siete = showSentenceEncrypted[seis]*)
