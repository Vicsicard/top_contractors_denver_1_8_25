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
  GiFencer
} from 'react-icons/gi';

export const getCategoryIcon = (categoryName: string): IconType => {
  const iconMap: { [key: string]: IconType } = {
    'Plumbers': FaWrench,
    'Electricians': FaBolt,
    'HVAC': FaSnowflake,
    'Roofers': FaHome,
    'Carpenters': FaHammer,
    'Painters': FaPaintBrush,
    'Landscapers': FaTree,
    'Home Remodelers': MdHome,
    'Bathroom Remodelers': FaBath,
    'Kitchen Remodelers': MdKitchen,
    'Siding & Gutters': FaWarehouse,
    'Masonry': GiBrickWall,
    'Decks': GiWoodBeam,
    'Flooring': GiWoodBeam,
    'Windows': FaWindowMaximize,
    'Fencing': GiFencer,
    'Epoxy Garage': FaWarehouse
  };

  return iconMap[categoryName] || MdHome;
};
