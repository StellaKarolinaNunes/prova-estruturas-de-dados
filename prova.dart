void main() {
  final lista = DoublyLinkedList<int>();
  lista.adicionar(10); // 0
  lista.adicionar(20); // 1
  lista.adicionar(30); // 2
  lista.adicionar(40); // 3
  final temp = lista.noEm(2);
  print(lista.removeAfter(temp!));
  print('$lista');
}

class DoublyNode<T> {
  T valor;
  DoublyNode<T>? proximo;
  DoublyNode<T>? anterior;

  DoublyNode(this.valor, {this.proximo, this.anterior});

  @override
  String toString() => proximo == null ? '$valor' : '$valor <-> $proximo';
}

class DoublyLinkedList<E> {
  DoublyNode<E>? inicio;
  DoublyNode<E>? fim;

  bool get vazio => inicio == null;

  void empurrar(E valor) {
    inicio = DoublyNode(valor, proximo: inicio);
    if (inicio!.proximo != null) {
      inicio!.proximo!.anterior = inicio;
    }
    fim ??= inicio;
  }

  void adicionar(E valor) {
    if (vazio) {
      empurrar(valor);
      return;
    }
    fim!.proximo = DoublyNode(valor, anterior: fim);
    fim = fim!.proximo;
  }

  DoublyNode<E>? noEm(int indice) {
    var atual = inicio;
    var contador = 0;
    while (atual != null && contador < indice) {
      atual = atual.proximo;
      contador++;
    }
    return atual;
  }

  DoublyNode<E> inserirDepois(DoublyNode<E> node, E valor) {
    if (fim == node) {
      adicionar(valor);
      return fim!;
    }
    node.proximo = DoublyNode(valor, proximo: node.proximo, anterior: node);
    node.proximo!.proximo!.anterior = node.proximo;
    return node.proximo!;
  }

  E? pop() {
    final value = inicio?.valor;
    inicio = inicio?.proximo;
    if (vazio) {
      fim = null;
    } else {
      inicio!.anterior = null;
    }
    return value;
  }

  E? removeLast() {
    if (inicio?.proximo == null) {
      return pop();
    }
    var current = inicio;
    while (current!.proximo != fim) {
      current = current.proximo;
    }
    final value = fim?.valor;
    fim = current;
    fim?.proximo = null;
    return value;
  }

  E? removeAfter(DoublyNode<E> node) {
    final value = node.proximo?.valor;
    fim ??= node;
    if (node.proximo != null) {
      node.proximo = node.proximo!.proximo;
      if (node.proximo != null) {
        node.proximo!.anterior = node;
      }
    }
    return value;
  }

  @override
  String toString() => vazio ? 'Lista vazia' : inicio.toString();
}
