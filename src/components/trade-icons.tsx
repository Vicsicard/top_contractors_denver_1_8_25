import { IconType } from 'react-icons';
import { 
  FaWrench, 
  FaBolt, 
  FaSnowflake, 
  FaHome,
  FaHammer,
  FaPaintBrush,
  FaTree,
  FaBath,
  FaWarehouse,
  FaWindowMaximize
} from 'react-icons/fa';
import { 
  MdHome,
  MdKitchen,
} from 'react-icons/md';
import { 
  GiWoodBeam, 
  GiBrickWall,
  GiGarage,
  GiFenceGate
} from 'react-icons/gi';

export const getCategoryIcon = (categoryName: string): IconType => {
  const iconMap: { [key: string]: IconType } = {
    'Plumber': FaWrench,
    'Electrician': FaBolt,
    'HVAC': FaSnowflake,
    'Roofer': FaHome,
    'Carpenter': FaHammer,
    'Painter': FaPaintBrush,
    'Landscaper': FaTree,
    'Home Remodeling': MdHome,
    'Bathroom Remodeling': FaBath,
    'Kitchen Remodeling': MdKitchen,
    'Siding & Gutters': FaWarehouse,
    'Masonry': GiBrickWall,
    'Decks': GiWoodBeam,
    'Flooring': GiWoodBeam,
    'Windows': FaWindowMaximize,
    'Fencing': GiFenceGate,
    'Epoxy Garage': GiGarage
  };

  return iconMap[categoryName] || MdHome;
};
