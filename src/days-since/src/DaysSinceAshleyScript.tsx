import React from "react";
import { useEffect, useState } from "react";

const LOCAL_STORAGE_KEY = "lastScriptStartDate";

function getStoredDate() {
  const stored = localStorage.getItem(LOCAL_STORAGE_KEY);
  return stored ? new Date(stored) : new Date("2025-04-26");
}

function setStoredDate(date: Date) {
  localStorage.setItem(LOCAL_STORAGE_KEY, date.toISOString());
}

function calculateDaysSince(date: Date) {
  const now = new Date();
  return Math.floor((now.getTime() - date.getTime()) / (1000 * 60 * 60 * 24));
}

export default function DaysSinceAshleyScript() {
  const [lastDate, setLastDate] = useState(getStoredDate());
  const [days, setDays] = useState(calculateDaysSince(lastDate));

  useEffect(() => {
    const interval = setInterval(() => {
      setDays(calculateDaysSince(lastDate));
    }, 60 * 1000);
    return () => clearInterval(interval);
  }, [lastDate]);

  const handleReset = () => {
    const now = new Date();
    setStoredDate(now);
    setLastDate(now);
    setDays(0);
  };


  return (
    <div style={{ textAlign: 'center', marginTop: '5rem' }}>
      <h1 style={{ fontSize: '2rem', marginBottom: '1rem' }}>



        ¡Hola mundo!




      </h1>
      <div style={{ fontSize: '4rem', fontWeight: 'bold', color: '#ec4899' }}>{days}</div>
      <button onClick={handleReset} style={{ marginTop: '2rem', padding: '1rem', fontSize: '1rem' }}>
        Reset to Today
      </button>
    </div>
  );
}
