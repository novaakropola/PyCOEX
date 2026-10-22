costs = zeros(25)
i = 1
costs(i,i+1) = 200; costs(i,i) = -400;                     i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++

costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++

costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++

costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++

costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
costs(i,i+1) = 200; costs(i,i) = -400; costs(i,i-1) = 200; i++
                    costs(i,i) = -400; costs(i,i-1) = 200; i++

input=zeros(25,1)
input(6) = -25

costs(1:10, 1:10)^-1*input(1:10)
costs(1:15, 1:15)^-1*input(1:15)
costs(1:20, 1:20)^-1*input(1:20)
costs^-1*input
