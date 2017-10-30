from Bandeirinha import Bandeirinha

class BandeirinhaQuadrado(Bandeirinha):
    def desenha(self):
        Bandeirinha.desenha(self)
        fill(255)
        rect(self.x - self.tamanho / 8, self.y - self.tamanho / 8, self.tamanho / 4, self.tamanho / 4)
        