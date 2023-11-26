import React, { useState, useEffect } from 'react';
import style from './Main.module.css';
import axios from 'axios';
import ReactOnRails from 'react-on-rails';

const Main = (user) => {
  const handleLogin = async () => {
    window.location.href = '/auth/google_oauth2';
  }

  // const handleLogout = async () => {
  //   const response = await axios.delete('/logout', {
  //     headers: {
  //       'X-CSRF-Token': ReactOnRails.authenticityToken()
  //     }
  //   });
  //   if (response.status === 200) {
  //     alert("You've been logged out!")
  //     window.location.href = '/';
  //   }
  // };

  const handleRandomize = async () => {
    const response = await axios.get('/assign', {
      headers: {
        'X-CSRF-Token': ReactOnRails.authenticityToken()
      }
    });
    if (response.status === 200) {
      alert("Secret Santas have been assigned!")
      window.location.href = '/';
    }
  }
  console.log(user)

  return (
    <div className={style.container}>
      <div className={style.containerTwo}>
        {/* <nav className={style.navbar}> */}
        <div className={style.title}>
          <h1>Secret Santa</h1>
          <h1>2023</h1>
        </div>
        {/* </nav> */}

        { user.first_name ?
          <div className={style.logged_in}>
            <h3>Hi, {user.first_name}!</h3>
            { user.secret_santa ?
              <div className={style.secretSanta}>
                <br />
                <p>You're secret santa is:</p>
                <h3>{user.secret_santa}!</h3>
                { user.first_name === "Beatriz" ? 
                <div className={style.secretSanta}>
                  <br />
                  <p>Steven's secret santa is:</p>
                  <i>Only you can see this Bea!</i>
                  <h3>{user.steven_ss}</h3>
                </div>
                : null }
              </div>
              :
              <div className={style.secretSanta}>
                <p>You're signed up!</p>
                <p>Come back on Sunday November 26th to see who your secret santa is!</p>
              </div>
            }
          </div>
          : 
          <div className={style.not_logged_in}>
            <p>Do you want to join our secret santa?</p>
            <p className={style.limit}>$60 Gift Limit</p>
            <p className={style.limit}>Gifts will be exchanged on Dec. 25th</p>
            <p>Log in with your google account and you'll be included!</p>
 
            <button type="button" className={style.google_sign_in_button} onClick={handleLogin}>
              Sign in with Google
            </button>
          </div>
        }

        { user.first_name === 'Axel' ?
          <div className={style.admin}>
            <button type="button" className={style.assignSSButton} onClick={handleRandomize}>
              Assign Secret Santas
            </button>
          </div>
          : null
        }
      </div>
    </div>
    
  );
};


export default Main;
