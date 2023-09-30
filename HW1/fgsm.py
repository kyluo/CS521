import torch
import torch.nn as nn
import torch.optim as optim


# fix seed so that random initialization always performs the same 
torch.manual_seed(1)


# create the model N as described in the question
N = nn.Sequential(nn.Linear(10, 10, bias=False),
                  nn.ReLU(),
                  nn.Linear(10, 10, bias=False),
                  nn.ReLU(),
                  nn.Linear(10, 3, bias=False))

# random input
x = torch.rand((1,10)) # the first dimension is the batch size; the following dimensions the actual dimension of the data
x.requires_grad_() # this is required so we can compute the gradient w.r.t x
print(N(x))

t = 0 # target class

epsReal = 0.4 #depending on your data this might be large or small
eps = epsReal - 1e-7 # small constant to offset floating-point erros

# The network N classfies x as belonging to class 2
# print(N(x))
# print(N.state_dict())
original_class = N(x).argmax(dim=1).item()  # TO LEARN: make sure you understand this expression
print("Original Class: ", original_class)
assert(original_class == 2)

# compute gradient
# note that CrossEntropyLoss() combines the cross-entropy loss and an implicit softmax function
L = nn.CrossEntropyLoss()
loss = L(N(x), torch.tensor([t], dtype=torch.long)) # TO LEARN: make sure you understand this line
loss.backward()

# your code here
# adv_x should be computed from x according to the fgsm-style perturbation such that the new class of xBar is the target class t above
# hint: you can compute the gradient of the loss w.r.t to x as x.grad

# part 1
adv_x = x - eps * x.grad.sign() 

# part 2
c = eps
softmax = nn.Softmax(dim=1)

eta = torch.zeros((1, 10))
eta.requires_grad = True
optimizer = optim.Adam([eta], lr=0.0001)

itr = 0
while (N(x + eta).argmax(dim=1).item() != t):
  optimizer.zero_grad()
  eta.data = torch.clamp(eta, x-eps, x+eps) # remove to find point
  loss1 = torch.norm(eta, p=float('inf'))
  loss2 = c * max(0, 0.5 - softmax(N(x + eta))[0][t])
  loss = loss1 + loss2

  loss.backward()
  optimizer.step()

  itr += 1
  if (itr % 10000 == 0):
    print(itr)

adv_x = x + eta
print(itr, adv_x, torch.norm((x-adv_x), p=float('inf')))

new_class = N(adv_x).argmax(dim=1).item()
print(N(adv_x))

print("New Class: ", new_class)
assert(new_class == t)
# it is not enough that adv_x is classified as t. We also need to make sure it is 'close' to the original x. 
assert( torch.norm((x-adv_x), p=float('inf')) <= epsReal)

