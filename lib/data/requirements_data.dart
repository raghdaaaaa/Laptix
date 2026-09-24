```dart
import '../models/laptop_requirements.dart';

final Map<String, LaptopRequirements> requirements = {
  'Study': LaptopRequirements(
    cpu: 'Basic',
    ram: 8,
    storage: 256,
    gpu: 'Integrated',
  ),

  'Office / Browsing': LaptopRequirements(
    cpu: 'Basic',
    ram: 8,
    storage: 256,
    gpu: 'Integrated',
  ),

  'Programming': LaptopRequirements(
    cpu: 'Medium',
    ram: 16,
    storage: 512,
    gpu: 'Integrated',
  ),

  'Web Development': LaptopRequirements(
    cpu: 'Medium',
    ram: 16,
    storage: 512,
    gpu: 'Integrated',
  ),

  'Android Development': LaptopRequirements(
    cpu: 'High',
    ram: 16,
    storage: 512,
    gpu: 'Integrated',
  ),

  'Graphic Design': LaptopRequirements(
    cpu: 'Medium',
    ram: 16,
    storage: 512,
    gpu: 'Entry-level Dedicated',
  ),

  'Video Editing': LaptopRequirements(
    cpu: 'High',
    ram: 32,
    storage: 1024,
    gpu: 'Dedicated',
  ),

  'AI / Machine Learning': LaptopRequirements(
    cpu: 'High',
    ram: 32,
    storage: 1024,
    gpu: 'Dedicated',
  ),

  'Gaming': LaptopRequirements(
    cpu: 'High',
    ram: 16,
    storage: 512,
    gpu: 'Dedicated',
  ),

  '3D / CAD': LaptopRequirements(
    cpu: 'High',
    ram: 32,
    storage: 1024,
    gpu: 'Dedicated',
  ),
};
```
