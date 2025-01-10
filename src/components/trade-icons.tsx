import { IconType } from 'react-icons';
import { FaWrench, FaBolt, FaSnowflake, FaHome, FaHammer } from 'react-icons/fa';
import { MdBrush, MdLandscape, MdHome, MdBathtub, MdKitchen } from 'react-icons/md';
import { GiStoneBrick, GiWoodBeam } from 'react-icons/gi';
import { BsWindow } from 'react-icons/bs';
import { TbGarage } from 'react-icons/tb';
import { BiSolidFence } from 'react-icons/bi';

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
    'Masonry': GiStoneBrick,
    'Decks': GiWoodBeam,
    'Flooring': GiWoodBeam,
    'Windows': BsWindow,
    'Fencing': BiSolidFence,
    'Epoxy Garage': TbGarage
  };

  return iconMap[categoryName] || MdHome;
};
