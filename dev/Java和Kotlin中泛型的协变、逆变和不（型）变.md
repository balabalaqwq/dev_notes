# Java和Kotlin中泛型的协变、逆变和不（型）变

> 引珞泽珈群 https://www.jianshu.com/p/0c2948f7e656  
> Kotlin中文站 http://www.kotlincn.net/docs/reference/generics.html

## 泛型（Generics）的型变

- 什么是泛型的型变（协变、逆变、不型变）？
- 为什么需要泛型的型变？
  
   > 根本目的是在保证泛型类 类型安全的基础上，提高API的灵活性，手段是通过编译器限制泛型类上某些方法的调用。

- Java和Kotlin分别是如何处理泛型型变的？

### 概念

假设Orange类是Fruit类的子类，Create<T>是一个泛型类。

1.  型变（type variance）

> Type variance refers to the techniques by which we can allow, or not allow, subtyping in our parameterized types.

**型变是指我们是否允许对参数类型进行子类型转换。**


> 那么Create<Orange> 和 Create<Fruit>有什么关系？  
> - Java： 两者没有关系。
> - Kotlin: **取决于Create<T> 中的 T 在Create类中如何使用的；Create<Orange>可能是Create<Fruit>的子类型，或者其超类型，或者两者没有关系。

2. 不型变（invariance)

> Create<Orange> 和 Create<Fruit> 之间没有关系。

3. 协变（covariance）

> Create<Orange> 是 Create<Fruit> 的子类型。

4. 逆变（contrevariance）  

> Create<Fruit> 是 Create<Orange> 的子类型。

> 注意： 
> 上面在解释协变、逆变概念时的说法只是为了帮助理解，这种说法对于Java而言并不准确。在Java中，Crate<Orange> 和 Crate<Fruit> 永远没有关系，对于协变应该这么说， Crate<Orange> 是 Crate<? extends Fruit> 的子类型，逆变则是，Crate<Fruit> 是 Crate<? super Orange> 的子类型。  
> 子类（subclass） 和 子类型（subtype）不是一个概念，子类一定是子类型，子类型不一定是子类，例如，Crate<Orange> 是 Crate<? extends Fruit> 的子类型，但是Crate<Orange> 并不是 Crate<? extends Fruit> 的子类。