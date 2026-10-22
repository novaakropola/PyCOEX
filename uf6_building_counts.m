costs = zeros(25)
i = 1
costs(i,i+1) = 229; costs(i,i) = -400;                     i++
costs(i,i+1) = 222; costs(i,i) = -400; costs(i,i-1) = 182; i++
costs(i,i+1) = 246; costs(i,i) = -400; costs(i,i-1) = 171; i++
costs(i,i+1) = 194; costs(i,i) = -400; costs(i,i-1) = 178; i++
costs(i,i+1) = 212; costs(i,i) = -400; costs(i,i-1) = 154; i++

costs(i,i+1) = 226; costs(i,i) = -400; costs(i,i-1) = 206; i++
costs(i,i+1) = 220; costs(i,i) = -400; costs(i,i-1) = 188; i++
costs(i,i+1) = 223; costs(i,i) = -400; costs(i,i-1) = 174; i++
costs(i,i+1) = 223; costs(i,i) = -400; costs(i,i-1) = 180; i++
costs(i,i+1) = 221; costs(i,i) = -400; costs(i,i-1) = 177; i++

costs(i,i+1) = 222; costs(i,i) = -400; costs(i,i-1) = 177; i++
costs(i,i+1) = 223; costs(i,i) = -400; costs(i,i-1) = 179; i++
costs(i,i+1) = 222; costs(i,i) = -400; costs(i,i-1) = 178; i++
costs(i,i+1) = 221; costs(i,i) = -400; costs(i,i-1) = 177; i++
costs(i,i+1) = 223; costs(i,i) = -400; costs(i,i-1) = 178; i++

costs(i,i+1) = 221; costs(i,i) = -400; costs(i,i-1) = 179; i++
costs(i,i+1) = 223; costs(i,i) = -400; costs(i,i-1) = 177; i++
costs(i,i+1) = 222; costs(i,i) = -400; costs(i,i-1) = 179; i++
costs(i,i+1) = 223; costs(i,i) = -400; costs(i,i-1) = 177; i++
costs(i,i+1) = 222; costs(i,i) = -400; costs(i,i-1) = 178; i++

costs(i,i+1) = 222; costs(i,i) = -400; costs(i,i-1) = 177; i++
costs(i,i+1) = 222; costs(i,i) = -400; costs(i,i-1) = 178; i++
costs(i,i+1) = 222; costs(i,i) = -400; costs(i,i-1) = 178; i++
costs(i,i+1) = 222; costs(i,i) = -400; costs(i,i-1) = 178; i++
                    costs(i,i) = -400; costs(i,i-1) = 178; i++

input=zeros(25,1)
input(6) = -2000/.8

costs(1:10, 1:10)^-1*input(1:10)
costs(1:15, 1:15)^-1*input(1:15)
costs(1:20, 1:20)^-1*input(1:20)
costs^-1*input
