from Bandeirinha import Bandeirinha

class BandeirinhaQuadrado(Bandeirinha):
    def __init__(self, px, py, ptamanho=None):
        Bandeirinha.__init__(self, px, py, ptamanho)
        
    def desenha(self):
        Bandeirinha.desenha(self)
        fill(255)
        ellipse(self.x, self.y, self.tamanho / 4, self.tamanho / 4)
        