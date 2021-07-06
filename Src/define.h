#ifndef DEFINE_H
#define DEFINE_H

#include <QVector>

//学生信息
typedef struct _STUDENT{
    QString name;   //姓名
    int score1;     //语文成绩
    int score2;     //数学成绩
    int score3;     //外语成绩
    _STUDENT()
    {
        name = "";
        score1 = score2 = score3 = 0;
    }
}STUDENT,*PSTUDENT;

//班级信息
typedef struct _CLASS{
    QString name;   //班级
    QVector<STUDENT*> students;
    _CLASS()
    {
        name = "";
    }
}CLASS;


#endif // DEFINE_H
