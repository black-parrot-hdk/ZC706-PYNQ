
import pynq
from pynq import GPIO

__author__ = ""
__copyright__ = ""
__email__ = ""


class BaseOverlay(pynq.Overlay):
    def __init__(self, bitfile, **kwargs):
        super().__init__(bitfile, **kwargs)
        if self.is_loaded():
            pass
