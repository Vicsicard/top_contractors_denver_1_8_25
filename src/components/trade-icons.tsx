import { IconType } from 'react-icons';
import { FaWrench, FaBolt, FaSnowflake, FaHome, FaHammer } from 'react-icons/fa';
import { MdBrush, MdLandscape, MdHome, MdBathtub, MdKitchen } from 'react-icons/md';
import { GiBrickWall, GiWoodBeam, GiHomeGarage } from 'react-icons/gi';
import { BsWindow } from 'react-icons/bs';
import { BiFence } from 'react-icons/bi';

export const getCategoryIcon = (categoryName: string): IconType => {
  const iconMap: { [key: string]: IconType } = {
    'Plumber': FaWrench,
    'Electrician': FaBolt,
    'HVAC': FaSnowflake,
    'Roofer': FaHome,
    'Carpenter': FaHammer,
    'Painter': MdBrush,
    'Landscaper': MdLandscape,
    'Home Remodeling': MdHome,
    'Bathroom Remodeling': MdBathtub,
    'Kitchen Remodeling': MdKitchen,
    'Siding & Gutters': MdHome,
    'Masonry': GiBrickWall,
    'Decks': GiWoodBeam,
    'Flooring': GiWoodBeam,
    'Windows': BsWindow,
    'Fencing': BiFence,
    'Epoxy Garage': GiHomeGarage
  };

  return iconMap[categoryName] || MdHome;
};
