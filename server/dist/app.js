"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const mongoose_1 = __importDefault(require("mongoose"));
const cors_1 = __importDefault(require("cors"));
const app = (0, express_1.default)();
const port = process.env.PORT || 8080;
// DATABASE
mongoose_1.default.connect(`mongodb+srv://admin:${'4hGgszYmxZqjvOD1'}@cluster0.wqs9m.mongodb.net/Cluster0?retryWrites=true&w=majority`, err => {
    if (!err)
        console.log('Connection succes');
    else
        console.log('Error in connection' + err);
});
app.use(express_1.default.json());
app.use((0, cors_1.default)());
const studentController = require('./controllers/studentController');
app.use('/students', studentController);
app.get('/', (req, res) => {
    res.send('Server running...');
});
app.listen(port);
