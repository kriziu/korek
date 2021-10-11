"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const bcrypt_1 = __importDefault(require("bcrypt"));
const student_model_1 = __importDefault(require("../models/student.model"));
const router = (0, express_1.Router)();
const getStudent = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    let student;
    try {
        student = yield student_model_1.default.findById(req.params.id);
        if (!student) {
            return res
                .status(404)
                .json({ message: 'Cannot find student with that id' });
        }
    }
    catch (err) {
        const msg = err.message;
        if (msg)
            return res.status(500).send({ error: msg });
        res.status(500).send();
    }
    res.student = student;
    next();
});
// GETTING ONE
router.get('/:id', getStudent, (req, res) => {
    res.send(res.student);
});
// GETTING BY TEACHER ID
router.get('/', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        if (req.query.teacherId) {
            const allStudents = yield student_model_1.default.find();
            const students = allStudents.filter(student => {
                let returnStudent = false;
                student.teachers.forEach(teacher => {
                    if (teacher._id === req.query.teacherId)
                        returnStudent = true;
                });
                if (returnStudent)
                    return true;
                return false;
            });
            res.json(students);
        }
        else {
            res.status(500).send({ error: 'Please add teacher id to your query!' });
        }
    }
    catch (err) {
        const msg = err.message;
        if (msg)
            return res.status(500).send({ error: msg });
        res.status(500).send();
    }
}));
// CREATING NEW
router.post('/', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const hashedPassword = yield bcrypt_1.default.hash(req.body.password, 10);
        const student = new student_model_1.default({
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            email: req.body.email,
            password: hashedPassword,
            subjects: req.body.subjects,
            teachers: req.body.teachers,
        });
        try {
            const newStudent = yield student.save();
            res.status(201).json(newStudent);
        }
        catch (err) {
            const msg = err.message;
            if (msg)
                return res.status(400).send({ error: msg });
            res.status(500).send();
        }
    }
    catch (err) {
        const msg = err.message;
        if (msg)
            return res.status(500).send({ error: msg });
        res.status(500).send();
    }
}));
// LOGGING
router.post('/login', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const student = yield student_model_1.default.findOne({ email: req.body.email });
    if (student == null)
        return res.status(400).json({ error: 'Cannot find user' });
    console.log(student);
    try {
        if (yield bcrypt_1.default.compare(req.body.password, student.password)) {
            res.send('Succes');
        }
        else
            res.send('Not allowed');
    }
    catch (err) {
        const msg = err.message;
        if (msg)
            return res.status(500).send({ error: msg });
        res.status(500).send();
    }
}));
// UPDATING ONE
router.patch('/:id', getStudent, (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    if (res.student) {
        if (req.body.firstName) {
            res.student.firstName = req.body.firstName;
        }
        if (req.body.lastName) {
            res.student.lastName = req.body.lastName;
        }
        if (req.body.email) {
            res.student.email = req.body.email;
        }
        if (req.body.password) {
            res.student.email = req.body.password;
        }
        if (req.body.subjects) {
            res.student.subjects = req.body.subjects;
        }
        if (req.body.teachers) {
            res.student.teachers = req.body.teachers;
        }
        try {
            const updatedStudent = yield res.student.save();
            res.json(updatedStudent);
        }
        catch (err) {
            const msg = err.message;
            if (msg)
                return res.status(400).send({ error: msg });
            res.status(500).send();
        }
    }
    else
        res.status(404).json({ error: 'Student with that id not found' });
}));
module.exports = router;
