import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tennis/blocs/court_detail_bloc.dart';
import 'package:tennis/blocs/reservation_bloc.dart';
import 'package:tennis/blocs/wheater_bloc.dart';
import 'package:tennis/models/court.dart';
import 'package:tennis/models/reservation.dart';
import 'package:tennis/screens/components/rounded_buttom.dart';
import 'package:tennis/screens/court-detail/components/input_container_form.dart';
import 'package:tennis/screens/court-detail/components/subtitle_form.dart';

class FormCourtDetail extends StatefulWidget {
  const FormCourtDetail({
    super.key,
  });

  @override
  State<FormCourtDetail> createState() => _FormCourtDetailState();
}

class _FormCourtDetailState extends State<FormCourtDetail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController clientNameController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  bool isDateSelected = true;
  bool isStartTimeSelected = true;
  bool isEndTimeSelected = true;

  bool isCourtAvailable = false;

  void showAvailabilityDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Lo sentimos'),
          content:
              const Text('La fecha seleccionada ya no tiene disponibilidad'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void createReservation() {
    int id = int.parse(DateFormat('yyMMddHHmmssSSS').format(DateTime.now()));
    int hours = endTime!.hour - startTime!.hour;

    CourtDetailState state = BlocProvider.of<CourtDetailBloc>(context).state;

    if (state is CourtDetailLoaded) {
      CourtModel court = state.court;
      BlocProvider.of<CourtDetailBloc>(context).add(
        AddReservationEvent(
          reservation: ReservationModel(
            id: id,
            idCourt: court.id,
            date: selectedDate!,
            reservedBy: clientNameController.text,
            hours: hours,
            price: hours * court.priceByHour,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<CourtDetailBloc, CourtDetailState>(
      listener: (context, state) {
        if (state is CourtDetailLoaded) {
          isCourtAvailable = state.isAvailable;
          if (selectedDate != null && !isCourtAvailable) {
            showAvailabilityDialog();
          }
        } else if (state is ReservationSuccess) {
          context.read<ReservationBloc>().add(GetReservations());
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (BuildContext context, WeatherState state) {
              log("State $state");
              if (state is WeatherLoaded) {
                return Text(
                  'Probabilidad de lluvia: ${state.rainProbability}',
                );
              } else if (state is WeatherLoading) {
                return const Text('Error al obtener la probabilidad');
              } else {
                return const Text('No se pudo obtener la probabilidad');
              }
            },
          ),
          const SubtitleForm(title: 'Establecer fecha y hora'),
          GestureDetector(
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                setState(() {
                  selectedDate = date;
                  isDateSelected = true;
                  BlocProvider.of<CourtDetailBloc>(context).add(
                    CheckAvailabilityEvent(date: date),
                  );

                  BlocProvider.of<WeatherBloc>(context).add(
                    FetchWeather(date: date),
                  );
                });
              }
            },
            child: InputContainerForm(
              showError: isDateSelected,
              children: [
                Text(
                  selectedDate == null
                      ? 'Fecha'
                      : DateFormat('dd/MM/yyyy').format(selectedDate!),
                ),
                const Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        startTime = time;
                        isStartTimeSelected = true;
                      });
                    }
                  },
                  child: InputContainerForm(
                    showError: isStartTimeSelected,
                    children: [
                      Text(
                        startTime == null
                            ? 'Hora de inicio'
                            : startTime!.format(context),
                      ),
                      const Icon(Icons.access_time, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        endTime = time;
                        isEndTimeSelected = true;
                      });
                    }
                  },
                  child: InputContainerForm(
                    showError: isEndTimeSelected,
                    children: [
                      Text(
                        endTime == null
                            ? 'Hora de fin'
                            : endTime!.format(context),
                      ),
                      const Icon(Icons.access_time, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SubtitleForm(title: 'Establecer Cliente'),
          TextFormField(
            controller: clientNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Reservar para...',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el nombre del cliente';
              }
              return null;
            },
          ),
          const SubtitleForm(title: 'Agregar un comentario'),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Agregar un comentario...',
            ),
            maxLines: 3,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: size.width * 0.8,
              child: RoundedButton(
                text: 'Reservar',
                onPressed: () {
                  setState(() {
                    isDateSelected = selectedDate != null;
                    isStartTimeSelected = startTime != null;
                    isEndTimeSelected = endTime != null;
                  });

                  if (_formKey.currentState!.validate() &&
                      isDateSelected &&
                      isStartTimeSelected &&
                      isEndTimeSelected) {
                    if (isCourtAvailable) {
                      createReservation();
                    } else {
                      showAvailabilityDialog();
                    }
                  }
                },
                color: const Color.fromARGB(255, 170, 247, 36),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
