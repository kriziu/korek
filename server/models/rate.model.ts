import mongoose from 'mongoose';

export interface RateType {
  teacherId: string;
  from: any;
  stars: number;
  message: string;
}

const rateSchema = new mongoose.Schema<RateType>({
  teacherId: {
    type: String,
    required: true,
  },
  from: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  stars: {
    type: Number,
    required: true,
    validate: {
      validator: Number.isInteger,
      message: `{VALUE} in not an integer`,
    },
    min: 1,
    max: 5,
  },
  message: { type: String, required: true },
});

export default mongoose.model<RateType>('Rate', rateSchema);
