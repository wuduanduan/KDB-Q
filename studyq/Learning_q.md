## [Learning q](https://code.kx.com/q/learn/startingkdb/)

### q language characters
* Inteprete language(可以直接做计算)
* Dynamic type language (int, float16,32, 64, date)
* Vectorize programming
* Functionnal programming

### KDB+
* data in kdb+ is column oriented database. Each column is stored in contiguous memory, both in-process and on-disk.
* KDB+ take advantages of modern CPU, having some custom interfaces to accelerate vector processing.

### Start q session from terminal
<pre>q/m64/q -p 5000</pre>

### Data types and operation
#### Date and time
* Calculated from right to left
> b: 1 + a:42 /赋值给b <- 1 + 42
* dateform: YYYY.MM.DD, hourform: hh:mm:ss.till_nanosecond
* `j` means long type
* A datetime (deprecated) is the lexical combination of a date and a time, separated by T as in the ISO standard format.
* `e`: real type; `e` also for times 10^x
* Casting to another type: ``int$2020.01.01``


#### List 
* A list: (e1; e2; e3). Elements can be of different type. But mixed types in lists take longer processing time than homogenous lists of atoms.
* x# give the first x elements in a list or last x elements if x is negative. # Always returns a list. If x = 0, return a empty list. If x is greater than the length of the list, it repeat from the begining to give elements.
* Iterator: "/". This symbol is called "Over" in q.
>3 +/ 1 2 3 /returns 4 5 6. 
* 44 | 8 returns 44 since:
> a|b / max(a,b)
> a & b / min(a,b)
* Scan: "\". Comparing to Over, this operation returns all intermediate values.
* Newton's method for solving sqrt(2): 
>{[xn] xn-((xn `*` xn)-2)%2 `*` xn}/[1.5]

	Since $f(x) = x^p$. $f'(x) = px^{p-1}$. Iteration: $ x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)} $. 

	Therefore to calculate the p-power root of constant c we have:

> nt1:{[p;c;xn] xn-((( `*`/) p#xn)-c)%(p `*` ( `*`/)(p-1)#xn)} 

* "\\:" Each Left notation: every elment in the left list will do this operation.

#### Dictionary
* A dictionary is of form: (key1 key2 key3) ! (val1 val2 val3)
* If keys are unique, (`u# key1 key2 key3) ! (val1 val2 val3) makes a hash table.

#### q-sql
* SELECT in SQL operates on fields on a row-by-row basis, select performs vector operations on column lists.
* select from t (no need of * as in SQL)
* select ... from ... where
* update: similar to select, but NOT in place update

#### Table
* A table is a flipped column dictionary, and also a list of record of dictionaries. Construct a table: ([] c1:10 20; c2:1 2)

	> t:([] c1:1000+til 6; c2:`a`b`c`a`b`a; c3:10 * 1+til 6) 
* Find the best time to buy and then sell:
	> select max px-mins px from trades where sym= stock_name

#### Char and I/O
* 反引号+\:path/filename
* `0:` : operator of overload. 
> `: path 0:("meaning"; "of"; "work")` will save each work in one line in the inferred file.
* For char atoms, comparing the underlying numeric value follows the ASCII collation sequence, while symbol comparison is based on lexicographic order.

### Build-in functions and operators:
* deltas
* each : take rows in an array as items
* flip : transpose of 2d table(key and value in a dictionary). Remark: only change the way that the table is shown but not how the data is store.
* `?`: generates pseudo-random data. 
* xbar: interval width + xbar + a list of numeric values (像是一个篮子，或者histogram的下边的标记左端点).
* wavg: weighted avg. Weights + wavg + Elements.
* Find: The Find operator is (an overload of) binary ? that returns the index of the first occurrence of the right operand in the left operand. If not in the list, return count(list)
* Distinct: similar to the `set` in python.
* Match: `~`, return a binary to indicate similar or not.
* Not equal :  '<>', actually it does `not equation`.
* ceiling: 进位取整; floor: 退位取整. Attention: do not apply to short types. 


### Minors points:
#### Function of the square brackets:
* referring the index in a list
* mark variable in lambda functions
* ([] c1:10 20; c2:1 2), in this example, "[]" means not it's not a list but a table.
* `\P` command (note upper case) to specify a display width up to 16 digits, `\P 0` le console will display all 17 decimal.
* Alias: created by `::`.
* Force the display with .Q.s1
* if `a:42` and we want to negate a: `neg a` not `-a`.
* Amend: `:`. Amend can be inplace: `,:`, `&:`, `+:` etc
* Integer division: `div`
* `ON` vs `On`


### Quiz:
* How to add comments for oneline? Multiple line?
* Whether q is sensible to space ?
* What command used to print variable ?
* 4 % 2 returns what ?
* 34 = 43 returns what ?
* 2000.12.27 + 10 returns ?
* '`appl' vs 'appl' ? `apple = `orange ? ('`' used for string) 
* what returns 3 + 2* til 3 ?
* 0#0 returns what ?
* {x+y}[4,5] ?
* 240 {x%y}/ 3# 10 3 2 2 2
* (\*/) 1+ til 10 = 10! ?
* 10 {x,sum -2#x}/ 1 1 
* Get -5 from -4.2 ; -4 from -4.2 ?
* What is the type 99h ? what does the `h` mean ?
* What does this return: `(`symbol$() ! `float$())`
* Non-unique keys are tolerated, if lookup, what's the return ?
* d1:`a`b`c ! 10 20 30
	d2:`c`d ! 300 400`
	Whether d1,d2 and d2, d1 return the same result ?
* What is a local variable in q? How many local variable are avaliable ?



### Answers:
* by "/"; No; show; 2f; 0b; 2001.01.06; 0b; 3 5 7; `symbol$() (`; 9; 4f; first 12 elements of fibonacci numbers; using floor and ceiling; Dictionary; A typed empty dictionary with typed empty key and value; only the first occurrence will be return; No, the later occurrence will overwrite the exist occurrence; A variable exists only for the duration of an application, not visible outside its immediate scope of definition, for now maximum 24 variables are avaliable;

### Questions:
* test: {[x;y] x*x + y*y} \n test[3;4] = 57 ?!

### Bugs:
这个语言用起来比较烦人的点：除法是%； 写表达式的时候是从右到左看；list里边元素分隔号为分号";"；赋值符号是=；在console里边执行的时候没有快捷键？上下左右键都会被显示为[[D]]这种...

