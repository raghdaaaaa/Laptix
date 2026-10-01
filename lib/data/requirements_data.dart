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

// Major minimum requirements (used as baseline before applying usage requirements)
// Keys must match AppStrings.major* exactly.
final Map<String, LaptopRequirements> majorMinimums = {
  'Computer Science': LaptopRequirements(
    cpu: 'Medium',
    ram: 16,
    storage: 512,
    gpu: 'Integrated',
  ),
  'Engineering': LaptopRequirements(
    cpu: 'Medium',
    ram: 16,
    storage: 512,
    gpu: 'Integrated',
  ),
  'Business': LaptopRequirements(
    cpu: 'Basic',
    ram: 8,
    storage: 256,
    gpu: 'Integrated',
  ),
  'Design': LaptopRequirements(
    cpu: 'Medium',
    ram: 16,
    storage: 512,
    gpu: 'Entry-level Dedicated',
  ),
  'Media': LaptopRequirements(
    cpu: 'Medium',
    ram: 16,
    storage: 512,
    gpu: 'Entry-level Dedicated',
  ),
  'Other': LaptopRequirements(
    cpu: 'Basic',
    ram: 8,
    storage: 256,
    gpu: 'Integrated',
  ),
};

// Budget caps (maximum specs allowed per budget tier)
// Keys must match AppStrings.budget*Value exactly.
final Map<String, LaptopRequirements> budgetCaps = {
  'Under \$800': LaptopRequirements(
    cpu: 'Medium',
    ram: 16,
    storage: 512,
    gpu: 'Integrated',
  ),
  '\$800 - \$1,200': LaptopRequirements(
    cpu: 'Medium',
    ram: 16,
    storage: 512,
    gpu: 'Entry-level Dedicated',
  ),
  '\$1,200 - \$1,800': LaptopRequirements(
    cpu: 'High',
    ram: 32,
    storage: 1024,
    gpu: 'Dedicated',
  ),
  '\$1,800+': LaptopRequirements(
    cpu: 'High',
    ram: 32,
    storage: 1024,
    gpu: 'Dedicated',
  ),
};