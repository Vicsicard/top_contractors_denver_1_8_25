import Image from 'next/image';
import styles from '@/styles/Header.module.css';

interface HeaderProps {
  title?: string;
  subtitle?: string;
}

export default function Header({ title, subtitle }: HeaderProps) {
  return (
    <header className={styles.header}>
      <div className={styles.imageWrapper}>
        <Image
          src="/images/denver-skyline.jpg"
          alt="Denver skyline with mountains at sunset"
          fill
          priority
          quality={90}
          className={styles.skylineImage}
          sizes="100vw"
        />
        <div className={styles.overlay}></div>
      </div>
      <div className={styles.content}>
        {title && <h1>{title}</h1>}
        {subtitle && <p>{subtitle}</p>}
      </div>
    </header>
  );
}
