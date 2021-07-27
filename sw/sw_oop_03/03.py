class Student :
    def __init__(self,name):
        self.__name = name

    @property
    def name(self):
        return self.__name

    def __str__(self):
        return "이름: {0}".format(self.__name)

class GreduateStudent(Student):

    def __init__(self, name, major):
        super().__init__(name)
        self.__major = major

    @property
    def major(self):
        return self.major

    def __str__(self):
        return super().__str__() + ", 전공: {0}".format(self.__major)
        


t = Student("홍길동")
r = GreduateStudent("이순신","컴퓨터")

print(t)
print(r)
