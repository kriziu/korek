import mongoose from 'mongoose';

export interface MessageType {
  roomId: string;
  from: string;
  message: string;
}

const messageSchema = new mongoose.Schema<MessageType>({
  roomId: {
    type: String,
    required: true,
  },
  from: { type: String, required: true },
  message: { type: String, required: true },
});

export default mongoose.model<MessageType>('Message', messageSchema);
