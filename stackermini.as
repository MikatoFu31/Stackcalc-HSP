/*-------------------------------------------------------------------------------------------------*/
/*                                                                                                 */
/*                              Tiny Stack Machine version 1.0.0 beta                              */
/*          Stack calc module with reverse polish notation , for Hot Soup Processor 3.4 .          */
/*                                 Made by MikatoFu31 , on 2017.10.1                               */
/*                                                                                                 */
/*-------------------------------------------------------------------------------------------------*/
/*                                                                                                 */
/*                                                                                                 */
/*    MIT License                                                                                  */
/*                                                                                                 */
/*    Copyright (c) 2017                                                                           */
/*                                                                                                 */
/*        Permission is hereby granted, free of charge, to any person obtaining a copy             */
/*        of this software and associated documentation files (the "Software"), to deal            */
/*        in the Software without restriction, including without limitation the rights             */
/*        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell                */
/*        copies of the Software, and to permit persons to whom the Software is                    */
/*        furnished to do so, subject to the following conditions:                                 */
/*                                                                                                 */
/*        The above copyright notice and this permission notice shall be included in all           */
/*        copies or substantial portions of the Software.                                          */
/*                                                                                                 */
/*        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR               */
/*        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,                 */
/*        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE              */
/*        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER                   */
/*        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,            */
/*        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE            */
/*        SOFTWARE.                                                                                */
/*                                                                                                 */
/*                                                                                                 */
/*-------------------------------------------------------------------------------------------------*/
/*                                                                                                 */
/*                                                                                                 */
/*     Preparation:                                                                                */
/*         Copy this file to same folder to your source code .                                     */
/*         Then add the following code in your source code :                                       */
/*             #include "stackermini.as"                                                           */
/*     How to use:                                                                                 */
/*         Calculate with TSM :                                                                    */
/*             TSM(" #code... ")                                                                   */
/*                 You can calculate a  TSM formula using this function.                           */
/*                 Put a RPN formula at " #code... " (Required to be Strings)                      */
/*                 This function returns result of formula in Strings.                             */
/*                 You can use the following RPN commands:                                         */
/*                     + - * / mod . .s dup drop                                                   */
/*                                                                                                 */
/*                                                                                                 */
/*-------------------------------------------------------------------------------------------------*/
/*                                                                                                 */
/*                                                                                                 */
/*    //Sample code:                                                                               */
/*        mes tsm("1 2 . .") //result: 1 2                                                         */
/*        mes tsm("3 4 + .") //result: 7                                                           */
/*        mes tsm("5 6 + 7 8 + * .") //result: 165                                                 */
/*                                                                                                 */
/*                                                                                                 */
/*-------------------------------------------------------------------------------------------------*/
/*                                                                                                 */
/*                                                                                                 */
/*    Your bug reports is welcomed ! Please contact with me !                                      */
/*        Github Repository: https://github.com/MikatoFu31/Stackcalc-HSP                           */
/*        Twitter : https://twitter.com/mikatofu31                                                 */
/*        Mail: ksoft2015@gmail.com                                                                */
/*                                                                                                 */
/*                                                                                                 */
/*-------------------------------------------------------------------------------------------------*/
#module tsmmodule
#defcfunc tsm str codes
*init
	sdim code,65536
	code=codes
	sdim wordone,64

*start
		dim error
		dim stack,256
		dim stackindex
		dim wordone,256
		dim wordindex
		
		sdim console,131072
*main
		getstr wordone,code,wordindex,' ',32
		wordindex+=strsize
		if wordone=int(wordone){
			stack(stackindex)=int(wordone)
			stackindex++
		}
		if wordone="dup"{
			stack(stackindex)=stack(limit(stackindex-1,0,length(stack)))
			stackindex++
		}
		if wordone="."{
			console+=str(stack(limit(stackindex-1,0,length(stack))))+" "
			stackindex--
		}
		if wordone=".s"{
			console+="[ "
			for count,0,stackindex,1
				console+=str(stack(count))+" "
			next
			console+="]"
		}
		if wordone="drop"{
			stack(limit(stackindex-1,0,length(stack)))=0
			stackindex--
		}
		if wordone="mod"{
			if stackindex>=2{
				stack(stackindex-2)=stack(stackindex-2)\stack(stackindex-1)
				stackindex--
			}else{
				dialog "stack over flow"
				error=1
			}
		}
		if wordone="+"{
			if stackindex>=2{
				stack(stackindex-2)=stack(stackindex-2)+stack(stackindex-1)
				stackindex--
			}else{
				dialog "stack over flow"
				error=1
			}
		}
		if wordone="-"{
			if stackindex>=2{
				stack(stackindex-2)=stack(stackindex-2)-stack(stackindex-1)
				stackindex--
			}else{
				dialog "stack over flow"
				error=1
			}
		}
		if wordone="*"{
			if stackindex>=2{
				stack(stackindex-2)=stack(stackindex-2)*stack(stackindex-1)
				stackindex--
			}else{
				dialog "stack over flow"
				error=1
			}
		}
		if wordone="/"{
			if stackindex>=2{
				stack(stackindex-2)=stack(stackindex-2)/stack(stackindex-1)
				stackindex--
			}else{
				dialog "stack over flow"
				error=1
			}
		}
		if stackindex>=length(stack) | stackindex<0{
			dialog "stack over flow"
			error=1
		}
		if wordindex>=strlen(code) | error=1:goto *endmain
		if wordone="":goto *main
		await 
		goto *main
*endmain
		return console
#global
