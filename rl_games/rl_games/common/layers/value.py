import torch
from torch import nn
from rl_games.common import common_losses
from rl_games.algos_torch.layers import symexp, symlog
from rl_games.common.extensions.distributions import TwoHotDist


class DefaultValue(nn.Module):
    def __init__(self, in_size, out_size):
        nn.Module.__init__(self)
        self.value_linear = nn.Linear(in_size, out_size)
        #torch.nn.init.xavier_uniform_(self.value_linear.weight, gain=0.05)
        
    def loss(self, value_preds_batch, values, curr_e_clip, return_batch, clip_value):
        #value_preds_batch = symlog(value_preds_batch)
        #values = symlog(values)
        #return_batch = symlog(return_batch)
        return common_losses.default_critic_loss(value_preds_batch, values, curr_e_clip, return_batch, clip_value)

    def forward(self, input):
        out = self.value_linear(input)
        #out = symexp(out)
        return out


class TwoHotEncodedValue(nn.Module):
    def __init__(self, in_size, out_size):
        nn.Module.__init__(self)
        assert(out_size==1)
        self.value_linear = nn.Linear(in_size, 255)
        torch.nn.init.xavier_uniform_(self.value_linear.weight, gain=0.05)
        
    def loss(self, **kwargs):
        targets = kwargs.get('return_batch')
        targets = symlog(targets)

        neglog_prob = -self.distr.log_prob(targets) 
        return neglog_prob

    def forward(self, input):
        out = self.value_linear(input)
        self.distr = TwoHotDist(logits=out)
        out = self.distr.mode()
        out = symexp(out)
        return out
        